import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../core/services/ingredient_service.dart';
import '../../core/services/supabase_service.dart'; // <-- Add this import
import '../../core/models/ingredient.dart';
import '../../core/models/unit.dart';
import 'package:intl/intl.dart';

class IngredientScreen extends StatefulWidget {
  const IngredientScreen({super.key});

  @override
  State<IngredientScreen> createState() => _IngredientScreenState();
}

class _IngredientScreenState extends State<IngredientScreen> {
  final _ingredientService = GetIt.instance<IngredientService>();
  bool _isLoading = true;
  String? _error;
  List<Ingredient> _ingredients = [];

  @override
  void initState() {
    super.initState();
    _loadIngredients();
  }

  Future<void> _loadIngredients() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final ingredients = await _ingredientService.getIngredients();
      setState(() {
        _ingredients = ingredients;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  String _formatExpiration(DateTime? date) {
    if (date == null) return 'No expiration';
    return DateFormat('MMM d, y').format(date);
  }

  String _formatQuantity(Ingredient ingredient) {
    return '${ingredient.quantity} ${ingredient.quantityType.abbreviation}';
  }

  Color _getExpirationColor(DateTime? date) {
    if (date == null) return Colors.grey;
    final now = DateTime.now();
    final difference = date.difference(now).inDays;

    if (difference < 0) return Colors.red; // Expired
    if (difference < 3) return Colors.orange; // Expiring soon
    if (difference < 7) return Colors.amber; // Expiring this week 
    return Colors.green; // Good
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ingredients'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
        ),
      ),
      body: SafeArea(child: _buildBody()),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final added = await showDialog<Ingredient>(
            context: context,
            builder: (context) => _AddIngredientDialog(),
          );
          if (added != null) {
            await _loadIngredients();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Ingredient "${added.name}" added!')),
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
              onPressed: _loadIngredients,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_ingredients.isEmpty) {
      return const Center(
        child: Text('No ingredients found. Add some ingredients to get started!'),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadIngredients,
      child: Builder(
        builder: (context) => ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: _ingredients.length,
          itemBuilder: (context, index) {
            final ingredient = _ingredients[index];
            final isOut = ingredient.quantity == 0;
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              color: isOut ? Colors.red[50] : null,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: _getExpirationColor(ingredient.expiration),
                  child: const Icon(Icons.egg, color: Colors.white),
                ),
                title: Row(
                  children: [
                    Text(ingredient.name),
                    if (isOut)
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Out',
                            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_formatQuantity(ingredient)),
                    if (ingredient.expiration != null)
                      Text(
                        'Expires: ${_formatExpiration(ingredient.expiration)}',
                        style: TextStyle(
                          color: _getExpirationColor(ingredient.expiration),
                        ),
                      ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (ingredient.notes != null)
                      IconButton(
                        icon: const Icon(Icons.info_outline),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(ingredient.name),
                              content: Text(ingredient.notes!),
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
                      icon: const Icon(Icons.edit),
                      tooltip: 'Edit Ingredient',
                      onPressed: () async {
                        final updated = await showDialog<Ingredient>(
                          context: context,
                          builder: (context) => _EditIngredientDialog(ingredient: ingredient),
                        );
                        if (updated != null && mounted) {
                          await _loadIngredients();
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Ingredient "${updated.name}" updated!')),
                            );
                          }
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      tooltip: 'Delete Ingredient',
                      onPressed: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Delete Ingredient'),
                            content: Text('Are you sure you want to delete "${ingredient.name}"?'),
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
                            final service = GetIt.instance<IngredientService>();
                            await service.deleteIngredient(ingredient.id);
                            await _loadIngredients();
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Ingredient "${ingredient.name}" deleted!')),
                              );
                            }
                          } catch (e) {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Failed to delete ingredient: $e')),
                              );
                            }
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AddIngredientDialog extends StatefulWidget {
  @override
  State<_AddIngredientDialog> createState() => _AddIngredientDialogState();
}

class _AddIngredientDialogState extends State<_AddIngredientDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  Unit _selectedUnit = Unit.G;
  DateTime? _expiration;
  final _notesController = TextEditingController();
  bool _isSaving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365 * 5)),
    );
    if (picked != null) {
      setState(() {
        _expiration = picked;
      });
    }
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
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                TextFormField(
                  controller: _quantityController,
                  decoration: const InputDecoration(labelText: 'Quantity'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Required';
                    final n = double.tryParse(v);
                    if (n == null || n < 0) return 'Enter a valid number';
                    return null;
                  },
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
                Row(
                  children: [
                    Expanded(
                      child: Text(_expiration == null
                          ? 'No expiration'
                          : 'Expires: ${_expiration!.toLocal().toString().split(' ')[0]}'),
                    ),
                    TextButton(
                      onPressed: _pickDate,
                      child: const Text('Pick Date'),
                    ),
                  ],
                ),
                TextFormField(
                  controller: _notesController,
                  decoration: const InputDecoration(labelText: 'Notes (optional)'),
                ),
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
                    final userId = GetIt.instance<SupabaseService>()
                        .supabase.auth.currentUser?.id;
                    if (userId == null) {
                      throw Exception('User not authenticated');
                    }
                    // Prepare the map for insertion (do not include id)
                    final ingredientMap = {
                      'name': _nameController.text.trim(),
                      'quantity': double.parse(_quantityController.text.trim()),
                      'quantity_type': _selectedUnit.name,
                      'expiration': _expiration?.toIso8601String(),
                      'notes': _notesController.text.trim().isEmpty
                          ? null
                          : _notesController.text.trim(),
                      'user_id': userId,
                    };
                    // Remove null fields
                    ingredientMap.removeWhere((k, v) => v == null);
                    final service = GetIt.instance<IngredientService>();
                    final added = await service.addIngredientFromMap(ingredientMap);
                    Navigator.pop(context, added);
                  } catch (e) {
                    setState(() => _isSaving = false);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to add ingredient: $e')),
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

class _EditIngredientDialog extends StatefulWidget {
  final Ingredient ingredient;
  const _EditIngredientDialog({required this.ingredient});

  @override
  State<_EditIngredientDialog> createState() => _EditIngredientDialogState();
}

class _EditIngredientDialogState extends State<_EditIngredientDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _quantityController;
  Unit _selectedUnit = Unit.G;
  DateTime? _expiration;
  late TextEditingController _notesController;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.ingredient.name);
    _quantityController = TextEditingController(text: widget.ingredient.quantity.toString());
    _selectedUnit = widget.ingredient.quantityType;
    _expiration = widget.ingredient.expiration;
    _notesController = TextEditingController(text: widget.ingredient.notes ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _expiration ?? now,
      firstDate: now.subtract(const Duration(days: 365 * 10)),
      lastDate: now.add(const Duration(days: 365 * 10)),
    );
    if (picked != null) {
      setState(() {
        _expiration = picked;
      });
    }
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
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                TextFormField(
                  controller: _quantityController,
                  decoration: const InputDecoration(labelText: 'Quantity'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Required';
                    final n = double.tryParse(v);
                    if (n == null || n < 0) return 'Enter a valid number';
                    return null;
                  },
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
                Row(
                  children: [
                    Expanded(
                      child: Text(_expiration == null
                          ? 'No expiration'
                          : 'Expires: ${_expiration!.toLocal().toString().split(' ')[0]}'),
                    ),
                    TextButton(
                      onPressed: _pickDate,
                      child: const Text('Pick Date'),
                    ),
                  ],
                ),
                TextFormField(
                  controller: _notesController,
                  decoration: const InputDecoration(labelText: 'Notes (optional)'),
                ),
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
                    final updated = widget.ingredient.copyWith(
                      name: _nameController.text.trim(),
                      quantity: double.parse(_quantityController.text.trim()),
                      quantityType: _selectedUnit,
                      expiration: _expiration,
                      notes: _notesController.text.trim().isEmpty
                          ? null
                          : _notesController.text.trim(),
                    );
                    final service = GetIt.instance<IngredientService>();
                    await service.updateIngredient(updated.id, updated);
                    if (!mounted) return;
                    Navigator.pop(context, updated);
                  } catch (e) {
                    setState(() => _isSaving = false);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to update ingredient: $e')),
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