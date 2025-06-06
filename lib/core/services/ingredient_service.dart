import '../models/ingredient.dart';
import 'supabase_service.dart';

class IngredientService {
  final SupabaseService _supabase;

  IngredientService(this._supabase);

  // Get all ingredients for current user
  Future<List<Ingredient>> getIngredients() async {
    final response = await _supabase.query(
      'ingredients',
      select: '*',
      eq: {'user_id': _supabase.supabase.auth.currentUser?.id},
      orderBy: 'name',
    );

    return response.map((json) => Ingredient.fromJson(json)).toList();
  }

  // Get a single ingredient
  Future<Ingredient> getIngredient(String id) async {
    final response = await _supabase.query(
      'ingredients',
      select: '*',
      eq: {
        'id': id,
        'user_id': _supabase.supabase.auth.currentUser?.id,
      },
    );

    if (response.isEmpty) throw Exception('Ingredient not found');
    return Ingredient.fromJson(response.first);
  }

  // Add a new ingredient
  Future<Ingredient> addIngredient(Ingredient ingredient) async {
    final response = await _supabase.insert(
      'ingredients',
      {
        ...ingredient.toJson(),
        'user_id': _supabase.supabase.auth.currentUser?.id,
      },
    );

    return Ingredient.fromJson(response);
  }

  // Add a new ingredient from a map (for creation)
  Future<Ingredient> addIngredientFromMap(Map<String, dynamic> ingredientMap) async {
    final response = await _supabase.insert(
      'ingredients',
      ingredientMap,
    );
    return Ingredient.fromJson(response);
  }

  // Update an ingredient
  Future<Ingredient> updateIngredient(String id, Ingredient ingredient) async {
    final response = await _supabase.update(
      'ingredients',
      id,
      ingredient.toJson(),
    );

    return Ingredient.fromJson(response);
  }

  // Delete an ingredient
  Future<void> deleteIngredient(String id) async {
    await _supabase.delete('ingredients', id);
  }

  // Subscribe to ingredient changes
  Stream<List<Ingredient>> subscribeToIngredients() {
    return _supabase
        .subscribe(
          'ingredients',
          eq: 'userId',
          eqValue: _supabase.supabase.auth.currentUser?.id,
        )
        .map((list) => list.map((json) => Ingredient.fromJson(json)).toList());
  }
}