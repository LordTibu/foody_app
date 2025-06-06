import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get_it/get_it.dart';
import 'core/services/supabase_service.dart';
import 'core/services/recipe_service.dart';
import 'core/services/ingredient_service.dart';
import 'presentation/app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables from .env
  await dotenv.load();

  // Initialize Supabase using .env values directly
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? '',
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
  );

  // Setup dependency injection
  final getIt = GetIt.instance;
  
  // Register services
  getIt.registerSingleton<SupabaseService>(SupabaseService());
  getIt.registerSingleton<RecipeService>(RecipeService(getIt<SupabaseService>()));
  getIt.registerSingleton<IngredientService>(IngredientService(getIt<SupabaseService>()));

  runApp(const FoodyApp());
}