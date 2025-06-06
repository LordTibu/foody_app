import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/recipe.dart';
import 'supabase_service.dart';

class RecipeService {
  final SupabaseService _supabase;
  final String _groqApiKey;

  RecipeService(this._supabase)
      : _groqApiKey = dotenv.env['GROQ_API_KEY'] ?? '';

  // Get all recipes for current user
  Future<List<Recipe>> getRecipes() async {
    final response = await _supabase.query(
      'recipes',
      select: '''
        *,
        ingredients:recipe_ingredients (
          recipe_id,
          ingredient_id,
          quantity,
          quantity_type,
          notes,
          ingredient:ingredients (*)
        )
      ''',
      eq: {'created_by_id': _supabase.supabase.auth.currentUser?.id},
      orderBy: 'title',
    );

    return response.map((json) => Recipe.fromJson(json)).toList();
  }

  // Get a single recipe
  Future<Recipe> getRecipe(String id) async {
    final response = await _supabase.query(
      'recipes',
      select: '''
        *,
        ingredients:recipe_ingredients (
          recipe_id,
          ingredient_id,
          quantity,
          quantity_type,
          notes,
          ingredient:ingredients (*)
        )
      ''',
      eq: {
        'id': id,
        'created_by_id': _supabase.supabase.auth.currentUser?.id,
      },
    );

    if (response.isEmpty) throw Exception('Recipe not found');
    return Recipe.fromJson(response.first);
  }

  // Add a new recipe
  Future<Recipe> addRecipe(Recipe recipe) async {
    // First, insert the recipe
    final recipeResponse = await _supabase.insert(
      'recipes',
      {
        ...recipe.toJson(),
        'created_by_id': _supabase.supabase.auth.currentUser?.id,
      },
    );

    // Then, insert all recipe ingredients
    for (final ingredient in recipe.ingredients) {
      await _supabase.insert(
        'recipe_ingredients',
        {
          ...ingredient.toJson(),
          'recipe_id': recipeResponse['id'],
        },
      );
    }

    // Finally, get the complete recipe with all relations
    return await getRecipe(recipeResponse['id']);
  }

  // Add a new recipe from a map (for creation dialog)
  Future<Recipe> addRecipeFromMap(Map<String, dynamic> recipeMap) async {
    final response = await _supabase.insert(
      'recipes',
      recipeMap,
    );
    return getRecipe(response['id']);
  }

  // Update a recipe
  Future<Recipe> updateRecipe(String id, Recipe recipe) async {
    // First, update the recipe
    await _supabase.update(
      'recipes',
      id,
      recipe.toJson(),
    );

    // Delete all existing recipe ingredients
    await _supabase.supabase
        .from('recipe_ingredients')
        .delete()
        .eq('recipe_id', id);

    // Insert new recipe ingredients
    for (final ingredient in recipe.ingredients) {
      await _supabase.insert(
        'recipe_ingredients',
        {
          ...ingredient.toJson(),
          'recipe_id': id,
        },
      );
    }

    // Finally, get the complete recipe with all relations
    return await getRecipe(id);
  }

  // Delete a recipe
  Future<void> deleteRecipe(String id) async {
    // Recipe ingredients will be deleted automatically due to foreign key constraint
    await _supabase.delete('recipes', id);
  }

  // Get recipe suggestions
  Future<List<RecipeSuggestion>> getSuggestions({List<String>? ingredientNames, int limit = 3}) async {
    // Use provided ingredient names or fetch all user's ingredients
    List<String> names;
    if (ingredientNames != null && ingredientNames.isNotEmpty) {
      names = ingredientNames;
    } else {
      final ingredients = await _supabase.query(
        'ingredients',
        select: 'name',
        eq: {'user_id': _supabase.supabase.auth.currentUser?.id},
      );
      if (ingredients.isEmpty) {
        throw Exception('No ingredients found. Please add some ingredients first.');
      }
      names = ingredients.map((i) => i['name'] as String).toList();
    }

    final validUnits = ['G', 'KG', 'ML', 'L', 'PCS', 'TBSP', 'TSP', 'CUP', 'OZ', 'LB', 'SLICE', 'PINCH', 'OTHER'];
    
    final systemPrompt = '''
You are a professional chef API that ONLY outputs raw JSON arrays. Your response must be valid JSON with no additional text or markdown.
Each recipe in the array must follow this exact schema:
{
  "title": "string",
  "time": "number",
  "instructions": "string[] (detailed step-by-step instructions)",
  "notes": "string",
  "ingredients": [
    {
      "name": "string",
      "quantity": "number",
      "quantity_type": "${validUnits.join('|')}",
      "notes": "string"
    }
  ]
}''';

    final userPrompt = '''
Generate a JSON array containing exactly $limit recipes using these ingredients: ${names.join(', ')}.
Each recipe must:
1. Use realistic quantities and cooking times
2. Include detailed step-by-step instructions
3. List both required ingredients from the provided list and any essential additional ingredients
4. Use only the following units: ${validUnits.join(', ')}
5. Include proper preparation notes for ingredients''';

    final response = await http.post(
      Uri.parse('https://api.groq.com/openai/v1/chat/completions'),
      headers: {
        'Authorization': 'Bearer $_groqApiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'model': 'meta-llama/llama-4-scout-17b-16e-instruct',
        'messages': [
          {'role': 'system', 'content': systemPrompt},
          {'role': 'user', 'content': userPrompt}
        ],
        'temperature': 0.3, // Lower temperature for more consistent output
        'max_tokens': 2000,
      }),
    );

    if (response.statusCode != 200) {
      print('Groq API error: ${response.statusCode} ${response.body}');
      throw Exception('Failed to get recipe suggestions');
    }

    final suggestionsContent = jsonDecode(response.body)['choices'][0]['message']['content'];
    
    try {
      final parsed = jsonDecode(suggestionsContent) as List;
      return parsed.map((json) => RecipeSuggestion.fromJson(json)).take(limit).toList();
    } catch (e) {
      print('Failed to parse suggestions JSON: $e');
      throw Exception('Invalid recipe suggestions format received');
    }
  }

  // Save an AI-generated recipe suggestion
  Future<Recipe> saveSuggestion(RecipeSuggestion suggestion) async {
    final response = await _supabase.rpc(
      'save_recipe_suggestion',
      params: {
        'suggestion_data': suggestion.toJson(),
        'user_id': _supabase.supabase.auth.currentUser?.id,
      },
    );

    return Recipe.fromJson(response);
  }

  // Subscribe to recipe changes
  Stream<List<Recipe>> subscribeToRecipes() {
    return _supabase
        .subscribe(
          'recipes',
          eq: 'createdById',
          eqValue: _supabase.supabase.auth.currentUser?.id,
        )
        .map((list) => list.map((json) => Recipe.fromJson(json)).toList());
  }

  // Add ingredients to a recipe
  Future<void> addIngredientsToRecipe(String recipeId, List<Map<String, dynamic>> ingredients) async {
    for (final ing in ingredients) {
      await _supabase.insert('recipe_ingredients', {
        'recipe_id': recipeId,
        'ingredient_id': ing['ingredient_id'],
        'quantity': ing['quantity'],
        'quantity_type': ing['quantity_type'],
        'notes': ing['notes'],
      });
    }
  }
}