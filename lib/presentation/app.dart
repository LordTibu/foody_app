import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/recipe_list_screen.dart';
import 'screens/ingredient_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/suggestions_screen.dart';
import 'package:get_it/get_it.dart';
import '../core/services/supabase_service.dart';

class FoodyApp extends StatelessWidget {
  const FoodyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foody',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthScreen(),
        '/home': (context) => const HomeScreen(),
        '/recipes': (context) => const RecipeListScreen(),
        '/ingredients': (context) => const IngredientScreen(),
        '/suggestions': (context) => const SuggestionsScreen()
      },
    );
  }
}