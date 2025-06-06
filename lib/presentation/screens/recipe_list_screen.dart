import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../core/services/recipe_service.dart';
import '../../core/models/recipe.dart';
import 'recipe_detail_screen.dart';
import '../../core/services/supabase_service.dart';
import '../../core/services/ingredient_service.dart';
import '../../core/models/unit.dart'; // <-- Use the correct import for Unit

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({super.key});

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  final _recipeService = GetIt.instance<RecipeService>();
  bool _isLoading = true;
  String? _error;
  List<Recipe> _recipes = [];

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final recipes = await _recipeService.getRecipes();
      setState(() {
        _recipes = recipes;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  String _formatCookingTime(int? minutes) {
    if (minutes == null) return 'Time not specified';
    if (minutes < 60) return '$minutes min';
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;
    if (remainingMinutes == 0) return '${hours}h';
    return '${hours}h ${remainingMinutes}m';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipes'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
        ),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final added = await showDialog<Recipe>(
            context: context,
            builder: (context) => _AddRecipeDialog(),
          );
          if (added != null) {
            await _loadRecipes();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Recipe "${added.title}" added!')),
            );
          }
        },
        child: const Icon(Icons.add),
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
              onPressed: _loadRecipes,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_recipes.isEmpty) {
      return const Center(
        child: Text('No recipes found. Add some recipes to get started!'),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadRecipes,
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _recipes.length,
        itemBuilder: (context, index) {
          final recipe = _recipes[index];
          // Check for missing and not-enough ingredients
          final missingIngredients = recipe.ingredients.where((ing) =>
            ing.ingredient != null && ing.ingredient!.quantity == 0
          ).toList();
          final notEnoughIngredients = recipe.ingredients.where((ing) =>
            ing.ingredient != null &&
            ing.ingredient!.quantity > 0 &&
            ing.ingredient!.quantity < ing.quantity
          ).toList();
          final hasMissing = missingIngredients.isNotEmpty;
          final hasNotEnough = notEnoughIngredients.isNotEmpty;
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: ListTile(
              leading: recipe.imageUrl != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(recipe.imageUrl!),
                      backgroundColor: Colors.grey.shade200,
                    )
                  : CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: const Icon(Icons.restaurant, color: Colors.white),
                    ),
              title: Row(
                children: [
                  Text(recipe.title),
                  if (hasMissing)
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Tooltip(
                        message: 'You are missing ${missingIngredients.length} ingredient(s)',
                        child: Icon(Icons.warning_amber_rounded, color: Colors.red[700], size: 20),
                      ),
                    ),
                  if (hasNotEnough)
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Tooltip(
                        message: 'Not enough of ${notEnoughIngredients.length} ingredient(s)',
                        child: Icon(Icons.error_outline, color: Colors.orange[800], size: 20),
                      ),
                    ),
                ],
              ),
              subtitle: Row(
                children: [
                  Icon(Icons.timer_outlined, 
                       size: 16, 
                       color: Theme.of(context).colorScheme.secondary),
                  const SizedBox(width: 4),
                  Text(_formatCookingTime(recipe.time)),
                  const SizedBox(width: 16),
                  Icon(Icons.egg_outlined, 
                       size: 16, 
                       color: Theme.of(context).colorScheme.secondary),
                  const SizedBox(width: 4),
                  Text('${recipe.ingredients.length} ingredients'),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (recipe.notes != null)
                    IconButton(
                      icon: const Icon(Icons.info_outline),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(recipe.title),
                            content: Text(recipe.notes!),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Close'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    tooltip: 'Delete Recipe',
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Delete Recipe'),
                          content: Text('Are you sure you want to delete "${recipe.title}"?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Delete', style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );
                      if (confirm == true) {
                        try {
                          await _recipeService.deleteRecipe(recipe.id);
                          await _loadRecipes();
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Recipe "${recipe.title}" deleted!')),
                            );
                          }
                        } catch (e) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Failed to delete recipe: $e')),
                            );
                          }
                        }
                      }
                    },
                  ),
                ],
              ),
              onTap: () async {
                final updated = await Navigator.push<Recipe>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipeDetailScreen(recipe: recipe),
                  ),
                );
                if (updated != null) {
                  await _loadRecipes();
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class _AddRecipeDialog extends StatefulWidget {
  @override
  State<_AddRecipeDialog> createState() => _AddRecipeDialogState();
}

class _AddRecipeDialogState extends State<_AddRecipeDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _instructionsController = TextEditingController();
  final _notesController = TextEditingController();
  final _timeController = TextEditingController();
  bool _isSaving = false;
  List<Map<String, dynamic>> _ingredients = [];

  // Add a simple UI for adding ingredients (for demo purposes)
  Future<void> _addIngredientDialog() async {
    final allIngredients = await GetIt.instance<IngredientService>().getIngredients();
    String? selectedId;
    final quantityController = TextEditingController();
    Unit selectedUnit = Unit.G; // <-- Use Unit from models/unit.dart
    final notesController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Ingredient to Recipe'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: selectedId,
              items: allIngredients
                  .map((ing) => DropdownMenuItem(
                        value: ing.id,
                        child: Text(ing.name),
                      ))
                  .toList(),
              onChanged: (v) => selectedId = v,
              decoration: const InputDecoration(labelText: 'Ingredient'),
            ),
            TextFormField(
              controller: quantityController,
              decoration: const InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            DropdownButtonFormField<Unit>(
              value: selectedUnit,
              items: Unit.values
                  .map((u) => DropdownMenuItem(
                        value: u,
                        child: Text(u.abbreviation),
                      ))
                  .toList(),
              onChanged: (u) => selectedUnit = u!,
              decoration: const InputDecoration(labelText: 'Unit'),
            ),
            TextFormField(
              controller: notesController,
              decoration: const InputDecoration(labelText: 'Notes (optional)'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (selectedId != null && quantityController.text.isNotEmpty) {
                setState(() {
                  _ingredients.add({
                    'ingredient_id': selectedId,
                    'quantity': double.tryParse(quantityController.text) ?? 0.0,
                    'quantity_type': selectedUnit.name,
                    'notes': notesController.text.trim().isEmpty
                        ? null
                        : notesController.text.trim(),
                  });
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Recipe'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              TextFormField(
                controller: _timeController,
                decoration: const InputDecoration(labelText: 'Time (minutes)'),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return null;
                  final n = int.tryParse(v);
                  if (n == null || n < 0) return 'Enter a valid number';
                  return null;
                },
              ),
              TextFormField(
                controller: _instructionsController,
                decoration: const InputDecoration(labelText: 'Instructions'),
                minLines: 3,
                maxLines: 6,
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(labelText: 'Notes (optional)'),
              ),
              const SizedBox(height: 12),
              const Text('Ingredients for this recipe:', style: TextStyle(fontWeight: FontWeight.bold)),
              ..._ingredients.map((ing) => Text(
                  '- ${ing['ingredient_id']} (${ing['quantity']} ${ing['quantity_type']})')),
              TextButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Add Ingredient'),
                onPressed: _addIngredientDialog,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSaving ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isSaving
              ? null
              : () async {
                  if (!_formKey.currentState!.validate()) return;
                  setState(() => _isSaving = true);
                  try {
                    final userId = GetIt.instance<SupabaseService>()
                        .supabase.auth.currentUser?.id;
                    if (userId == null) {
                      throw Exception('User not authenticated');
                    }
                    final recipeMap = {
                      'title': _titleController.text.trim(),
                      'instructions': _instructionsController.text.trim(),
                      'notes': _notesController.text.trim().isEmpty
                          ? null
                          : _notesController.text.trim(),
                      'time': _timeController.text.trim().isEmpty
                          ? null
                          : int.tryParse(_timeController.text.trim()),
                      'created_by_id': userId,
                    };
                    recipeMap.removeWhere((k, v) => v == null);
                    final service = GetIt.instance<RecipeService>();
                    final added = await service.addRecipeFromMap(recipeMap);
                    // Add ingredients to the recipe
                    if (_ingredients.isNotEmpty) {
                      await service.addIngredientsToRecipe(added.id, _ingredients);
                    }
                    Navigator.pop(context, added);
                  } catch (e) {
                    setState(() => _isSaving = false);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to add recipe: $e')),
                    );
                  }
                },
          child: _isSaving
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Add'),
        ),
      ],
    );
  }
}