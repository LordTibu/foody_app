import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../core/services/recipe_service.dart';
import '../../core/models/recipe.dart';
import '../../core/services/ingredient_service.dart';
import '../../core/models/ingredient.dart';
import '../../core/services/supabase_service.dart';

class SuggestionsScreen extends StatefulWidget {
  const SuggestionsScreen({super.key});

  @override
  State<SuggestionsScreen> createState() => _SuggestionsScreenState();
}

class _SuggestionsScreenState extends State<SuggestionsScreen> {
  final _recipeService = GetIt.instance<RecipeService>();
  final _ingredientService = GetIt.instance<IngredientService>();
  bool _isLoading = true;
  String? _error;
  List<RecipeSuggestion> _suggestions = [];
  List<Ingredient> _allIngredients = [];
  Set<String> _selectedIngredientNames = {};
  bool _suggestionsVisible = false;

  @override
  void initState() {
    super.initState();
    _loadIngredients();
  }

  Future<void> _loadIngredients() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final ingredients = await _ingredientService.getIngredients();
      setState(() {
        _allIngredients = ingredients;
        _selectedIngredientNames = ingredients.map((i) => i.name).toSet();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _loadSuggestions() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final suggestions = await _recipeService.getSuggestions(
        ingredientNames: _selectedIngredientNames.toList(),
        limit: 5,
      );
      setState(() {
        _suggestions = suggestions;
        _isLoading = false;
        _suggestionsVisible = true;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
        _suggestionsVisible = false;
      });
    }
  }

  String fixEncoding(String input) {
    try {
      return utf8.decode(latin1.encode(input));
    } catch (_) {
      return input;
    }
  }

  Widget _buildIngredientSelector() {
    // Only show ingredients with quantity > 0
    final availableIngredients = _allIngredients.where((ingredient) => ingredient.quantity > 0).toList();
    if (availableIngredients.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text('No ingredients in stock. Add some ingredients first.'),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Wrap(
        spacing: 8,
        children: availableIngredients.map((ingredient) {
          final selected = _selectedIngredientNames.contains(ingredient.name);
          return FilterChip(
            label: Text(ingredient.name),
            selected: selected,
            onSelected: (val) {
              setState(() {
                if (val) {
                  _selectedIngredientNames.add(ingredient.name);
                } else {
                  _selectedIngredientNames.remove(ingredient.name);
                }
              });
            },
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Suggestions'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
        ),
      ),
      body: SafeArea(
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: $_error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadIngredients,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        _buildIngredientSelector(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.search),
                label: const Text('Get Suggestions'),
                onPressed: _selectedIngredientNames.isEmpty
                    ? null
                    : () async {
                        await _loadSuggestions();
                      },
              ),
              const SizedBox(width: 12)
            ],
          ),
        ),
        const Divider(),
        Expanded(
          child: !_suggestionsVisible
              ? Center(
                  child: Text(
                    _selectedIngredientNames.isEmpty
                        ? 'Select ingredients above.'
                        : 'Press "Get Suggestions" to see recipes.',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                )
              : (_suggestions.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('No suggestions available.'),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _loadSuggestions,
                            child: const Text('Get Suggestions'),
                          ),
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: _loadSuggestions,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: _suggestions.length,
                        itemBuilder: (context, index) {
                          final suggestion = _suggestions[index];
                          final recipeName = fixEncoding(suggestion.name).trim().isEmpty
                              ? 'Untitled Recipe'
                              : fixEncoding(suggestion.name);
                          final recipeDesc = fixEncoding(suggestion.description).trim().isEmpty
                              ? 'No description'
                              : fixEncoding(suggestion.description);
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                            child: ExpansionTile(
                              leading: const Icon(Icons.lightbulb_outline),
                              title: Text(recipeName),
                              subtitle: Text(recipeDesc),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Only show ingredients that are in stock (quantity > 0)
                                      if (suggestion.ingredients.isNotEmpty) ...[
                                        const Text('Ingredients in stock:', style: TextStyle(fontWeight: FontWeight.bold)),
                                        ...suggestion.ingredients
                                          .where((ing) {
                                            final stock = _allIngredients.firstWhere(
                                              (i) => i.name.trim().toLowerCase() == (ing['name'] ?? '').toString().trim().toLowerCase(),
                                              orElse: () => null as Ingredient, // workaround for nullable
                                            );
                                            return stock != null && stock.quantity > 0;
                                          })
                                          .map((ing) => Text(
                                            '- ${fixEncoding(ing['name'] ?? '')} '
                                            '${fixEncoding(ing['quantity'] ?? '')} '
                                            '${fixEncoding(ing['quantity_type'] ?? ing['quantityType'] ?? '')}'
                                            '${(ing['notes'] != null && ing['notes']!.isNotEmpty) ? ' (${fixEncoding(ing['notes']!)})' : ''}',
                                          )),
                                        const SizedBox(height: 8),
                                      ],
                                      if (suggestion.instructions.isNotEmpty) ...[
                                        const Text('Instructions:', style: TextStyle(fontWeight: FontWeight.bold)),
                                        ...suggestion.instructions.asMap().entries.map((entry) => Text('${entry.key + 1}. ${fixEncoding(entry.value)}')),
                                        const SizedBox(height: 8),
                                      ],
                                      Text('Cooking time: ${suggestion.cookingTime} min'),
                                      Text('Difficulty: ${fixEncoding(suggestion.difficulty)}'),
                                      const SizedBox(height: 8),
                                      ElevatedButton.icon(
                                        icon: const Icon(Icons.add),
                                        label: const Text('Save Recipe'),
                                        onPressed: () async {
                                          try {
                                            final userId = GetIt.instance<SupabaseService>()
                                                .supabase.auth.currentUser?.id;
                                            if (userId == null) {
                                              throw Exception('User not authenticated');
                                            }
                                            // Build the ingredients section as text
                                            String ingredientsSection = '';
                                            if (suggestion.ingredients.isNotEmpty) {
                                              ingredientsSection = 'Ingredients:\n' +
                                                suggestion.ingredients.map((ing) =>
                                                  '- ${fixEncoding(ing['name'] ?? '')} '
                                                  '${fixEncoding(ing['quantity'] ?? '')} '
                                                  '${fixEncoding(ing['quantity_type'] ?? ing['quantityType'] ?? '')}'
                                                  '${(ing['notes'] != null && ing['notes']!.isNotEmpty) ? ' (${fixEncoding(ing['notes']!)})' : ''}'
                                                ).join('\n') +
                                                '\n\n';
                                            }
                                            // Combine ingredients section and instructions
                                            final fullInstructions = ingredientsSection +
                                              suggestion.instructions.join('\n');
                                            final recipeMap = {
                                              'title': suggestion.name,
                                              'time': suggestion.cookingTime,
                                              'instructions': fullInstructions,
                                              'image_url': null,
                                              'notes': suggestion.description,
                                              'created_by_id': userId,
                                            };
                                            recipeMap.removeWhere((k, v) => v == null);
                                            final saved = await _recipeService.addRecipeFromMap(recipeMap);
                                            if (!mounted) return;
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text('Recipe "${saved.title}" added!')),
                                            );
                                          } catch (e) {
                                            if (!mounted) return;
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text('Failed to save recipe: $e')),
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )),
        ),
      ],
    );
  }
}