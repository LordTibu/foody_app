import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../core/models/recipe.dart';
import '../../core/models/unit.dart';
import '../../core/models/ingredient.dart';
import '../../core/services/recipe_service.dart';
import '../../core/services/supabase_service.dart'; // Add this import
import '../../core/services/ingredient_service.dart'; // Add this import

class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetailScreen({Key? key, required this.recipe}) : super(key: key);

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  late Recipe _recipe;

  @override
  void initState() {
    super.initState();
    _recipe = widget.recipe;
  }

  Future<void> _refreshRecipe() async {
    final service = GetIt.instance<RecipeService>();
    final updated = await service.getRecipe(_recipe.id);
    setState(() {
      _recipe = updated;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_recipe.title),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Edit Recipe',
            onPressed: () async {
              final updated = await showDialog<Recipe>(
                context: context,
                builder: (context) => _EditRecipeDialog(recipe: _recipe),
              );
              if (updated != null) {
                setState(() {
                  _recipe = updated;
                });
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refreshRecipe,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_recipe.imageUrl != null && _recipe.imageUrl!.isNotEmpty)
                  Center(
                    child: Image.network(
                      _recipe.imageUrl!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.restaurant, size: 100, color: Colors.grey),
                    ),
                  ),
                const SizedBox(height: 16),
                Text(
                  _recipe.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                if (_recipe.time != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.timer_outlined, size: 18),
                        const SizedBox(width: 4),
                        Text('${_recipe.time} min'),
                      ],
                    ),
                  ),
                if (_recipe.notes != null && _recipe.notes!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      _recipe.notes!,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                const SizedBox(height: 24),
                Text('Ingredients', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                ..._recipe.ingredients.map((ing) {
                  final ingredientName = ing.ingredient?.name ?? ing.ingredientId;
                  final pantryQty = ing.ingredient?.quantity ?? 0;
                  final neededQty = ing.quantity;
                  final isMissing = pantryQty == 0;
                  final notEnough = !isMissing && pantryQty < neededQty;
                  return ListTile(
                    leading: const Icon(Icons.egg),
                    title: Row(
                      children: [
                        Text(ingredientName),
                        if (isMissing)
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Tooltip(
                              message: 'You do not have this ingredient',
                              child: Icon(Icons.warning_amber_rounded, color: Colors.red[700], size: 20),
                            ),
                          ),
                        if (notEnough)
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Tooltip(
                              message: 'Not enough in stock (have $pantryQty, need $neededQty)',
                              child: Icon(Icons.error_outline, color: Colors.orange[800], size: 20),
                            ),
                          ),
                      ],
                    ),
                    subtitle: Text('${ing.quantity} ${ing.quantityType.abbreviation}${ing.notes != null && ing.notes!.isNotEmpty ? ' - ${ing.notes}' : ''}'),
                  );
                }),
                const SizedBox(height: 24),
                Text('Instructions', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text(_recipe.instructions),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EditRecipeDialog extends StatefulWidget {
  final Recipe recipe;
  const _EditRecipeDialog({required this.recipe});

  @override
  State<_EditRecipeDialog> createState() => _EditRecipeDialogState();
}

class _EditRecipeDialogState extends State<_EditRecipeDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _instructionsController;
  late TextEditingController _notesController;
  late TextEditingController _timeController;
  bool _isSaving = false;
  late List<RecipeIngredient> _ingredients;
  List<Ingredient> _allIngredients = [];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.recipe.title);
    _instructionsController = TextEditingController(text: widget.recipe.instructions);
    _notesController = TextEditingController(text: widget.recipe.notes ?? '');
    _timeController = TextEditingController(text: widget.recipe.time?.toString() ?? '');
    _ingredients = List<RecipeIngredient>.from(widget.recipe.ingredients);
    _loadAllIngredients();
  }

  Future<void> _loadAllIngredients() async {
    final ingredientService = GetIt.instance<IngredientService>();
    final ingredients = await ingredientService.getIngredients();
    setState(() {
      _allIngredients = ingredients;
    });
  }

  Future<Ingredient> _addNewIngredientToDb(String name, Unit unit) async {
    final ingredientService = GetIt.instance<IngredientService>();
    final supabaseService = GetIt.instance<SupabaseService>();
    final userId = supabaseService.supabase.auth.currentUser?.id;
    if (userId == null) {
      throw Exception('User not authenticated');
    }
    // Prepare the map for insertion (do not include id)
    final ingredientMap = {
      'name': name,
      'quantity': 0,
      'quantity_type': unit.name,
      'expiration': null,
      'notes': null,
      'user_id': userId,
    };
    // Remove null fields to avoid type errors
    ingredientMap.removeWhere((k, v) => v == null);
    final added = await ingredientService.addIngredientFromMap(ingredientMap);
    setState(() {
      _allIngredients.add(added);
    });
    return added;
  }

  void _addOrEditIngredient({RecipeIngredient? ingredient, int? index}) async {
    final result = await showDialog<RecipeIngredient>(
      context: context,
      builder: (context) => _EditIngredientDialog(
        ingredient: ingredient,
        allIngredients: _allIngredients,
        onAddNewIngredient: _addNewIngredientToDb,
      ),
    );
    if (result != null) {
      setState(() {
        if (index != null) {
          _ingredients[index] = result;
        } else {
          _ingredients.add(result);
        }
      });
    }
  }

  void _removeIngredient(int index) {
    setState(() {
      _ingredients.removeAt(index);
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _instructionsController.dispose();
    _notesController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      contentPadding: const EdgeInsets.all(16),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Form(
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
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text('Ingredients', style: TextStyle(fontWeight: FontWeight.bold)),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.add),
                      tooltip: 'Add Ingredient',
                      onPressed: () => _addOrEditIngredient(),
                    ),
                  ],
                ),
                ..._ingredients.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final ing = entry.value;
                  final name = ing.ingredient?.name ?? ing.ingredientId;
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.egg),
                    title: Text(name),
                    subtitle: Text('${ing.quantity} ${ing.quantityType.abbreviation}${ing.notes != null && ing.notes!.isNotEmpty ? ' - ${ing.notes}' : ''}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          tooltip: 'Edit',
                          onPressed: () => _addOrEditIngredient(ingredient: ing, index: idx),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          tooltip: 'Remove',
                          onPressed: () => _removeIngredient(idx),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
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
                    final updatedRecipe = widget.recipe.copyWith(
                      title: _titleController.text.trim(),
                      time: _timeController.text.trim().isEmpty
                          ? null
                          : int.tryParse(_timeController.text.trim()),
                      instructions: _instructionsController.text.trim(),
                      notes: _notesController.text.trim().isEmpty
                          ? null
                          : _notesController.text.trim(),
                      // Do NOT include ingredients here for the updateRecipe call below
                    );
                    final service = GetIt.instance<RecipeService>();
                    final supabaseService = GetIt.instance<SupabaseService>();
                    // Only send fields that exist in the recipes table
                    final recipeMap = {
                      'title': updatedRecipe.title,
                      'time': updatedRecipe.time,
                      'instructions': updatedRecipe.instructions,
                      'image_url': updatedRecipe.imageUrl,
                      'notes': updatedRecipe.notes,
                      'created_by_id': updatedRecipe.createdById,
                    };
                    recipeMap.removeWhere((k, v) => v == null);
                    await supabaseService.update(
                      'recipes',
                      updatedRecipe.id,
                      recipeMap,
                    );
                    // Now update ingredients separately if needed
                    await supabaseService.supabase
                        .from('recipe_ingredients')
                        .delete()
                        .eq('recipe_id', updatedRecipe.id);
                    for (final ing in _ingredients) {
                      await supabaseService.insert(
                        'recipe_ingredients',
                        {
                          'recipe_id': updatedRecipe.id,
                          'ingredient_id': ing.ingredientId,
                          'quantity': ing.quantity,
                          'quantity_type': ing.quantityType.name,
                          'notes': ing.notes,
                        },
                      );
                    }
                    final saved = await service.getRecipe(updatedRecipe.id);
                    if (!mounted) return;
                    Navigator.pop(context, saved);
                  } catch (e) {
                    setState(() => _isSaving = false);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to update recipe: $e')),
                    );
                  }
                },
          child: _isSaving
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Save'),
        ),
      ],
    );
  }
}

// Ingredient edit dialog
class _EditIngredientDialog extends StatefulWidget {
  final RecipeIngredient? ingredient;
  final List<Ingredient> allIngredients;
  final Future<Ingredient> Function(String name, Unit unit) onAddNewIngredient;
  const _EditIngredientDialog({
    this.ingredient,
    required this.allIngredients,
    required this.onAddNewIngredient,
  });

  @override
  State<_EditIngredientDialog> createState() => _EditIngredientDialogState();
}

class _EditIngredientDialogState extends State<_EditIngredientDialog> {
  final _formKey = GlobalKey<FormState>();
  Ingredient? _selectedIngredient;
  late TextEditingController _quantityController;
  Unit _selectedUnit = Unit.G;
  late TextEditingController _notesController;
  final _newIngredientNameController = TextEditingController();
  bool _addingNew = false;

  @override
  void initState() {
    super.initState();
    if (widget.ingredient != null) {
      _selectedIngredient = widget.allIngredients.firstWhere(
        (i) => i.id == widget.ingredient!.ingredientId,
        orElse: () => Ingredient(
          id: widget.ingredient!.ingredientId,
          name: widget.ingredient!.ingredient?.name ?? widget.ingredient!.ingredientId,
          quantity: 0,
          quantityType: widget.ingredient!.quantityType,
          expiration: null,
          notes: null,
          userId: '',
        ),
      );
    }
    _quantityController = TextEditingController(text: widget.ingredient?.quantity.toString() ?? '');
    _selectedUnit = widget.ingredient?.quantityType ?? Unit.G;
    _notesController = TextEditingController(text: widget.ingredient?.notes ?? '');
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _notesController.dispose();
    _newIngredientNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.ingredient == null ? 'Add Ingredient' : 'Edit Ingredient'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!_addingNew)
                DropdownButtonFormField<Ingredient>(
                  value: _selectedIngredient,
                  items: [
                    ...widget.allIngredients.map((i) => DropdownMenuItem(
                          value: i,
                          child: Text(i.name),
                        )),
                    const DropdownMenuItem<Ingredient>(
                      value: null,
                      child: Text('Add new ingredient...'),
                    ),
                  ],
                  onChanged: (i) {
                    if (i == null) {
                      setState(() {
                        _addingNew = true;
                        _selectedIngredient = null;
                      });
                    } else {
                      setState(() {
                        _selectedIngredient = i;
                        _addingNew = false;
                        _selectedUnit = i.quantityType; // Set unit to ingredient's unit
                      });
                    }
                  },
                  decoration: const InputDecoration(labelText: 'Ingredient'),
                  validator: (v) => v == null && !_addingNew ? 'Required' : null,
                ),
              if (_addingNew)
                Column(
                  children: [
                    TextFormField(
                      controller: _newIngredientNameController,
                      decoration: const InputDecoration(labelText: 'New Ingredient Name'),
                      validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                    ),
                    DropdownButtonFormField<Unit>(
                      value: _selectedUnit,
                      items: Unit.values
                          .map((u) => DropdownMenuItem(
                                value: u,
                                child: Text(u.abbreviation),
                              ))
                          .toList(),
                      onChanged: (u) => setState(() => _selectedUnit = u!),
                      decoration: const InputDecoration(labelText: 'Unit'),
                    ),
                  ],
                ),
              // Only show the unit selector if adding new ingredient
              if (!_addingNew)
                const SizedBox.shrink(),
              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Required';
                  final n = double.tryParse(v);
                  if (n == null || n <= 0) return 'Enter a valid number';
                  return null;
                },
              ),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(labelText: 'Notes (optional)'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (!_formKey.currentState!.validate()) return;
            Ingredient? ingredient = _selectedIngredient;
            if (_addingNew) {
              ingredient = await widget.onAddNewIngredient(
                _newIngredientNameController.text.trim(),
                _selectedUnit,
              );
            }
            Navigator.pop(
              context,
              RecipeIngredient(
                recipeId: '', // Will be set by backend
                ingredientId: ingredient!.id,
                quantity: double.parse(_quantityController.text.trim()),
                quantityType: _selectedUnit,
                notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
                ingredient: ingredient,
              ),
            );
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
