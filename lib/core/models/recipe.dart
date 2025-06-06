import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'ingredient.dart';
import 'unit.dart';

part 'recipe.freezed.dart';
part 'recipe.g.dart';

@freezed
class Recipe with _$Recipe {
  const factory Recipe({
    required String id,
    required String title,
    int? time,
    required String instructions,
    @JsonKey(name: 'image_url') String? imageUrl,
    String? notes,
    @JsonKey(name: 'created_by_id') required String createdById,
    @Default(<RecipeIngredient>[]) List<RecipeIngredient> ingredients,
  }) = _Recipe;

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);
}

@freezed
class RecipeIngredient with _$RecipeIngredient {
  const factory RecipeIngredient({
    @JsonKey(name: 'recipe_id') required String recipeId,
    @JsonKey(name: 'ingredient_id') required String ingredientId,
    required double quantity,
    @JsonKey(name: 'quantity_type') required Unit quantityType,
    String? notes,
    Ingredient? ingredient, // <-- Add this for Supabase join
  }) = _RecipeIngredient;

  factory RecipeIngredient.fromJson(Map<String, dynamic> json) =>
      _$RecipeIngredientFromJson(json);
}

@freezed
class RecipeSuggestion with _$RecipeSuggestion {
  const factory RecipeSuggestion({
    required String name,
    required String description,
    required List<String> instructions,
    required List<Map<String, String>> ingredients,
    @Default(30) int cookingTime,
    @Default('medium') String difficulty,
  }) = _RecipeSuggestion;

  factory RecipeSuggestion.fromJson(Map<String, dynamic> json) {
    // Defensive parsing for ingredients
    final rawIngredients = json['ingredients'] as List<dynamic>? ?? [];
    final parsedIngredients = rawIngredients.map<Map<String, String>>((item) {
      if (item is Map) {
        return item.map((k, v) => MapEntry(
          k?.toString() ?? '',
          v?.toString() ?? '',
        ));
      }
      return <String, String>{};
    }).toList();

    // Fallback logic for name and description
    final name = (json['name']?.toString() ?? '').trim().isNotEmpty
        ? json['name'].toString()
        : (json['title']?.toString() ?? '');
    final description = (json['description']?.toString() ?? '').trim().isNotEmpty
        ? json['description'].toString()
        : (json['notes']?.toString() ?? '');

    return RecipeSuggestion(
      name: name,
      description: description,
      instructions: (json['instructions'] as List<dynamic>?)
              ?.map((e) => e?.toString() ?? '')
              .toList() ??
          [],
      ingredients: parsedIngredients,
      cookingTime: (json['cookingTime'] as num?)?.toInt() ?? (json['time'] as num?)?.toInt() ?? 30,
      difficulty: json['difficulty']?.toString() ?? 'medium',
    );
  }
}

@freezed
class RecipeInstructions with _$RecipeInstructions {
  const factory RecipeInstructions({
    required List<RecipeStep> prep,
    required List<RecipeStep> cooking,
    required List<RecipeStep> plating,
  }) = _RecipeInstructions;

  factory RecipeInstructions.fromJson(Map<String, dynamic> json) =>
      _$RecipeInstructionsFromJson(json);
}

@freezed
class RecipeStep with _$RecipeStep {
  const factory RecipeStep({
    required int step,
    required String description,
    int? time,
    List<String>? tools,
    String? temperature,
    String? indicators,
  }) = _RecipeStep;

  factory RecipeStep.fromJson(Map<String, dynamic> json) =>
      _$RecipeStepFromJson(json);
}

@freezed
class RecipeIngredients with _$RecipeIngredients {
  const factory RecipeIngredients({
    required List<IngredientItem> available,
    required List<IngredientItem> missing,
  }) = _RecipeIngredients;

  factory RecipeIngredients.fromJson(Map<String, dynamic> json) =>
      _$RecipeIngredientsFromJson(json);
}

@freezed
class IngredientItem with _$IngredientItem {
  const factory IngredientItem({
    required String name,
    required double quantity,
    required String quantityType,
    String? notes,
  }) = _IngredientItem;

  factory IngredientItem.fromJson(Map<String, dynamic> json) =>
      _$IngredientItemFromJson(json);
}