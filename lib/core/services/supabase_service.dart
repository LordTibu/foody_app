import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final supabase = Supabase.instance.client;

  // Authentication
  Future<AuthResponse> signUp({
    required String email,
    required String password,
  }) async {
    try {
      // First check if user exists
      final existing = await supabase
          .from('auth.users')
          .select()
          .eq('email', email)
          .maybeSingle();

      if (existing != null) {
        // User exists, try to sign in
        return await signIn(email: email, password: password);
      }

      // Create new user
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'email_confirm': true,
          'email_confirmed_at': DateTime.now().toIso8601String(),
        },
      );

      if (response.user == null) {
        throw Exception('User creation failed');
      }

      return response;
    } catch (e) {
      print('Signup error: $e');
      rethrow;
    }
  }

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw Exception('Sign in failed');
      }

      return response;
    } catch (e) {
      print('Sign in error: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  // Create test user
  Future<AuthResponse> createTestUser() async {
    const email = 'test@example.com';
    const password = 'Test123!';

    try {
      // Try to sign in first in case the user already exists
      return await signIn(email: email, password: password);
    } catch (e) {
      print('Sign in failed, trying to create user: $e');
      // If sign in fails, create the user
      final response = await signUp(email: email, password: password);
      
      // Wait a bit for the user to be fully created
      await Future.delayed(const Duration(seconds: 2));
      
      // Seed test data for the new user
      if (response.user != null) {
        try {
          await supabase.rpc('seed_test_data', params: {'user_id': response.user!.id});
        } catch (seedError) {
          print('Error seeding data: $seedError');
          // Continue anyway since the user was created
        }
      }
      
      return response;
    }
  }

  // Database operations
  Future<List<Map<String, dynamic>>> query(
    String table, {
    String? select,
    Map<String, dynamic>? eq,
    String? orderBy,
  }) async {
    try {
      var builder = supabase.from(table).select(select ?? '*');
      if (eq != null) {
        eq.forEach((key, value) {
          builder = builder.eq(key, value);
        });
      }
      // Only chain .order() at the end, do not reassign
      final response = orderBy != null
          ? await builder.order(orderBy)
          : await builder;
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print('Error querying $table: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> insert(
    String table,
    Map<String, dynamic> data,
  ) async {
    final response = await supabase.from(table).insert(data).select();
    return response.first;
  }

  Future<Map<String, dynamic>> update(
    String table,
    String id,
    Map<String, dynamic> data,
  ) async {
    final response = await supabase
        .from(table)
        .update(data)
        .eq('id', id)
        .select();
    return response.first;
  }

  Future<void> delete(String table, String id) async {
    await supabase.from(table).delete().eq('id', id);
  }

  // Test data seeding
  Future<void> seedTestData() async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    // Add test ingredients
    final ingredients = [
      {
        'name': 'Tomato',
        'quantity': 500.0,
        'quantity_type': 'G',
        'expiration': DateTime.now().add(const Duration(days: 7)).toIso8601String(),
        'notes': 'Fresh Roma tomatoes',
        'user_id': userId,
      },
      {
        'name': 'Onion',
        'quantity': 2.0,
        'quantity_type': 'PCS',
        'expiration': DateTime.now().add(const Duration(days: 14)).toIso8601String(),
        'notes': 'Yellow onions',
        'user_id': userId,
      },
      {
        'name': 'Chicken Breast',
        'quantity': 1.0,
        'quantity_type': 'KG',
        'expiration': DateTime.now().add(const Duration(days: 3)).toIso8601String(),
        'notes': 'Fresh, skinless',
        'user_id': userId,
      },
      {
        'name': 'Rice',
        'quantity': 2.0,
        'quantity_type': 'CUP',
        'notes': 'Jasmine rice',
        'user_id': userId,
      },
      {
        'name': 'Olive Oil',
        'quantity': 500.0,
        'quantity_type': 'ML',
        'notes': 'Extra virgin',
        'user_id': userId,
      },
    ];

    final addedIngredients = [];
    for (final ingredient in ingredients) {
      final response = await insert('ingredients', ingredient);
      addedIngredients.add(response);
    }

    // Add test recipes
    final recipes = [
      {
        'title': 'Chicken Rice Bowl',
        'time': 30,
        'instructions': '''
1. Rinse rice and cook according to package instructions
2. Season chicken breast with salt and pepper
3. Heat olive oil in a pan over medium heat
4. Cook chicken for 6-7 minutes per side until done
5. Let chicken rest for 5 minutes, then slice
6. Serve chicken over rice with sautéed onions''',
        'image_url': null,
        'notes': 'Can be meal prepped for the week',
        'created_by_id': userId,
      },
    ];

    for (final recipe in recipes) {
      final addedRecipe = await insert('recipes', recipe);

      // Add recipe ingredients
      final recipeIngredients = [
        {
          'recipe_id': addedRecipe['id'],
          'ingredient_id': addedIngredients[2]['id'], // Chicken
          'quantity': 200.0,
          'quantity_type': 'G',
          'notes': 'Sliced',
        },
        {
          'recipe_id': addedRecipe['id'],
          'ingredient_id': addedIngredients[3]['id'], // Rice
          'quantity': 1.0,
          'quantity_type': 'CUP',
          'notes': null,
        },
        {
          'recipe_id': addedRecipe['id'],
          'ingredient_id': addedIngredients[4]['id'], // Olive Oil
          'quantity': 2.0,
          'quantity_type': 'TBSP',
          'notes': null,
        },
        {
          'recipe_id': addedRecipe['id'],
          'ingredient_id': addedIngredients[1]['id'], // Onion
          'quantity': 1.0,
          'quantity_type': 'PCS',
          'notes': 'Sliced',
        },
      ];

      for (final ingredient in recipeIngredients) {
        await insert('recipe_ingredients', ingredient);
      }
    }
  }

  // RPC calls
  Future<dynamic> rpc(String function, {Map<String, dynamic>? params}) async {
    return await supabase.rpc(function, params: params);
  }

  // Real-time subscriptions
  Stream<List<Map<String, dynamic>>> subscribe(
    String table, {
    String? eq,
    String? eqValue,
  }) {
    final stream = supabase.from(table).stream(primaryKey: ['id']);
    
    if (eq != null && eqValue != null) {
      return stream.eq(eq, eqValue);
    }

    return stream;
  }
}