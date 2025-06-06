// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecipeImpl _$$RecipeImplFromJson(Map<String, dynamic> json) => _$RecipeImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      time: (json['time'] as num?)?.toInt(),
      instructions: json['instructions'] as String,
      imageUrl: json['image_url'] as String?,
      notes: json['notes'] as String?,
      createdById: json['created_by_id'] as String,
      ingredients: (json['ingredients'] as List<dynamic>?)
              ?.map((e) => RecipeIngredient.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <RecipeIngredient>[],
    );

Map<String, dynamic> _$$RecipeImplToJson(_$RecipeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'time': instance.time,
      'instructions': instance.instructions,
      'image_url': instance.imageUrl,
      'notes': instance.notes,
      'created_by_id': instance.createdById,
      'ingredients': instance.ingredients,
    };

_$RecipeIngredientImpl _$$RecipeIngredientImplFromJson(
        Map<String, dynamic> json) =>
    _$RecipeIngredientImpl(
      recipeId: json['recipe_id'] as String,
      ingredientId: json['ingredient_id'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      quantityType: $enumDecode(_$UnitEnumMap, json['quantity_type']),
      notes: json['notes'] as String?,
      ingredient: json['ingredient'] == null
          ? null
          : Ingredient.fromJson(json['ingredient'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$RecipeIngredientImplToJson(
        _$RecipeIngredientImpl instance) =>
    <String, dynamic>{
      'recipe_id': instance.recipeId,
      'ingredient_id': instance.ingredientId,
      'quantity': instance.quantity,
      'quantity_type': _$UnitEnumMap[instance.quantityType]!,
      'notes': instance.notes,
      'ingredient': instance.ingredient,
    };

const _$UnitEnumMap = {
  Unit.G: 'G',
  Unit.KG: 'KG',
  Unit.ML: 'ML',
  Unit.L: 'L',
  Unit.PCS: 'PCS',
  Unit.TBSP: 'TBSP',
  Unit.TSP: 'TSP',
  Unit.CUP: 'CUP',
  Unit.OZ: 'OZ',
  Unit.LB: 'LB',
  Unit.SLICE: 'SLICE',
  Unit.PINCH: 'PINCH',
  Unit.OTHER: 'OTHER',
};

_$RecipeSuggestionImpl _$$RecipeSuggestionImplFromJson(
        Map<String, dynamic> json) =>
    _$RecipeSuggestionImpl(
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      instructions: (json['instructions'] as List<dynamic>?)
              ?.map((e) => e?.toString() ?? '')
              .toList() ??
          [],
      ingredients: (json['ingredients'] as List<dynamic>? ?? [])
          .map<Map<String, String>>((item) {
            if (item is Map) {
              return item.map((k, v) => MapEntry(
                k?.toString() ?? '',
                v?.toString() ?? '',
              ));
            }
            return <String, String>{};
          })
          .toList(),
      cookingTime: (json['cookingTime'] as num?)?.toInt() ?? 30,
      difficulty: json['difficulty']?.toString() ?? 'medium',
    );

Map<String, dynamic> _$$RecipeSuggestionImplToJson(
        _$RecipeSuggestionImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'instructions': instance.instructions,
      'ingredients': instance.ingredients,
      'cookingTime': instance.cookingTime,
      'difficulty': instance.difficulty,
    };

_$RecipeInstructionsImpl _$$RecipeInstructionsImplFromJson(
        Map<String, dynamic> json) =>
    _$RecipeInstructionsImpl(
      prep: (json['prep'] as List<dynamic>)
          .map((e) => RecipeStep.fromJson(e as Map<String, dynamic>))
          .toList(),
      cooking: (json['cooking'] as List<dynamic>)
          .map((e) => RecipeStep.fromJson(e as Map<String, dynamic>))
          .toList(),
      plating: (json['plating'] as List<dynamic>)
          .map((e) => RecipeStep.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$RecipeInstructionsImplToJson(
        _$RecipeInstructionsImpl instance) =>
    <String, dynamic>{
      'prep': instance.prep,
      'cooking': instance.cooking,
      'plating': instance.plating,
    };

_$RecipeStepImpl _$$RecipeStepImplFromJson(Map<String, dynamic> json) =>
    _$RecipeStepImpl(
      step: (json['step'] as num).toInt(),
      description: json['description'] as String,
      time: (json['time'] as num?)?.toInt(),
      tools:
          (json['tools'] as List<dynamic>?)?.map((e) => e as String).toList(),
      temperature: json['temperature'] as String?,
      indicators: json['indicators'] as String?,
    );

Map<String, dynamic> _$$RecipeStepImplToJson(_$RecipeStepImpl instance) =>
    <String, dynamic>{
      'step': instance.step,
      'description': instance.description,
      'time': instance.time,
      'tools': instance.tools,
      'temperature': instance.temperature,
      'indicators': instance.indicators,
    };

_$RecipeIngredientsImpl _$$RecipeIngredientsImplFromJson(
        Map<String, dynamic> json) =>
    _$RecipeIngredientsImpl(
      available: (json['available'] as List<dynamic>)
          .map((e) => IngredientItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      missing: (json['missing'] as List<dynamic>)
          .map((e) => IngredientItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$RecipeIngredientsImplToJson(
        _$RecipeIngredientsImpl instance) =>
    <String, dynamic>{
      'available': instance.available,
      'missing': instance.missing,
    };

_$IngredientItemImpl _$$IngredientItemImplFromJson(Map<String, dynamic> json) =>
    _$IngredientItemImpl(
      name: json['name'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      quantityType: json['quantityType'] as String,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$IngredientItemImplToJson(
        _$IngredientItemImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'quantity': instance.quantity,
      'quantityType': instance.quantityType,
      'notes': instance.notes,
    };
