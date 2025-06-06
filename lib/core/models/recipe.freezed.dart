// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Recipe _$RecipeFromJson(Map<String, dynamic> json) {
  return _Recipe.fromJson(json);
}

/// @nodoc
mixin _$Recipe {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  int? get time => throw _privateConstructorUsedError;
  String get instructions => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by_id')
  String get createdById => throw _privateConstructorUsedError;
  List<RecipeIngredient> get ingredients => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecipeCopyWith<Recipe> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeCopyWith<$Res> {
  factory $RecipeCopyWith(Recipe value, $Res Function(Recipe) then) =
      _$RecipeCopyWithImpl<$Res, Recipe>;
  @useResult
  $Res call(
      {String id,
      String title,
      int? time,
      String instructions,
      @JsonKey(name: 'image_url') String? imageUrl,
      String? notes,
      @JsonKey(name: 'created_by_id') String createdById,
      List<RecipeIngredient> ingredients});
}

/// @nodoc
class _$RecipeCopyWithImpl<$Res, $Val extends Recipe>
    implements $RecipeCopyWith<$Res> {
  _$RecipeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? time = freezed,
    Object? instructions = null,
    Object? imageUrl = freezed,
    Object? notes = freezed,
    Object? createdById = null,
    Object? ingredients = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int?,
      instructions: null == instructions
          ? _value.instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdById: null == createdById
          ? _value.createdById
          : createdById // ignore: cast_nullable_to_non_nullable
              as String,
      ingredients: null == ingredients
          ? _value.ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<RecipeIngredient>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecipeImplCopyWith<$Res> implements $RecipeCopyWith<$Res> {
  factory _$$RecipeImplCopyWith(
          _$RecipeImpl value, $Res Function(_$RecipeImpl) then) =
      __$$RecipeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      int? time,
      String instructions,
      @JsonKey(name: 'image_url') String? imageUrl,
      String? notes,
      @JsonKey(name: 'created_by_id') String createdById,
      List<RecipeIngredient> ingredients});
}

/// @nodoc
class __$$RecipeImplCopyWithImpl<$Res>
    extends _$RecipeCopyWithImpl<$Res, _$RecipeImpl>
    implements _$$RecipeImplCopyWith<$Res> {
  __$$RecipeImplCopyWithImpl(
      _$RecipeImpl _value, $Res Function(_$RecipeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? time = freezed,
    Object? instructions = null,
    Object? imageUrl = freezed,
    Object? notes = freezed,
    Object? createdById = null,
    Object? ingredients = null,
  }) {
    return _then(_$RecipeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int?,
      instructions: null == instructions
          ? _value.instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdById: null == createdById
          ? _value.createdById
          : createdById // ignore: cast_nullable_to_non_nullable
              as String,
      ingredients: null == ingredients
          ? _value._ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<RecipeIngredient>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecipeImpl implements _Recipe {
  const _$RecipeImpl(
      {required this.id,
      required this.title,
      this.time,
      required this.instructions,
      @JsonKey(name: 'image_url') this.imageUrl,
      this.notes,
      @JsonKey(name: 'created_by_id') required this.createdById,
      final List<RecipeIngredient> ingredients = const <RecipeIngredient>[]})
      : _ingredients = ingredients;

  factory _$RecipeImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecipeImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final int? time;
  @override
  final String instructions;
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @override
  final String? notes;
  @override
  @JsonKey(name: 'created_by_id')
  final String createdById;
  final List<RecipeIngredient> _ingredients;
  @override
  @JsonKey()
  List<RecipeIngredient> get ingredients {
    if (_ingredients is EqualUnmodifiableListView) return _ingredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ingredients);
  }

  @override
  String toString() {
    return 'Recipe(id: $id, title: $title, time: $time, instructions: $instructions, imageUrl: $imageUrl, notes: $notes, createdById: $createdById, ingredients: $ingredients)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.instructions, instructions) ||
                other.instructions == instructions) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdById, createdById) ||
                other.createdById == createdById) &&
            const DeepCollectionEquality()
                .equals(other._ingredients, _ingredients));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      time,
      instructions,
      imageUrl,
      notes,
      createdById,
      const DeepCollectionEquality().hash(_ingredients));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecipeImplCopyWith<_$RecipeImpl> get copyWith =>
      __$$RecipeImplCopyWithImpl<_$RecipeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecipeImplToJson(
      this,
    );
  }
}

abstract class _Recipe implements Recipe {
  const factory _Recipe(
      {required final String id,
      required final String title,
      final int? time,
      required final String instructions,
      @JsonKey(name: 'image_url') final String? imageUrl,
      final String? notes,
      @JsonKey(name: 'created_by_id') required final String createdById,
      final List<RecipeIngredient> ingredients}) = _$RecipeImpl;

  factory _Recipe.fromJson(Map<String, dynamic> json) = _$RecipeImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  int? get time;
  @override
  String get instructions;
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;
  @override
  String? get notes;
  @override
  @JsonKey(name: 'created_by_id')
  String get createdById;
  @override
  List<RecipeIngredient> get ingredients;
  @override
  @JsonKey(ignore: true)
  _$$RecipeImplCopyWith<_$RecipeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RecipeIngredient _$RecipeIngredientFromJson(Map<String, dynamic> json) {
  return _RecipeIngredient.fromJson(json);
}

/// @nodoc
mixin _$RecipeIngredient {
  @JsonKey(name: 'recipe_id')
  String get recipeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'ingredient_id')
  String get ingredientId => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'quantity_type')
  Unit get quantityType => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  Ingredient? get ingredient => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecipeIngredientCopyWith<RecipeIngredient> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeIngredientCopyWith<$Res> {
  factory $RecipeIngredientCopyWith(
          RecipeIngredient value, $Res Function(RecipeIngredient) then) =
      _$RecipeIngredientCopyWithImpl<$Res, RecipeIngredient>;
  @useResult
  $Res call(
      {@JsonKey(name: 'recipe_id') String recipeId,
      @JsonKey(name: 'ingredient_id') String ingredientId,
      double quantity,
      @JsonKey(name: 'quantity_type') Unit quantityType,
      String? notes,
      Ingredient? ingredient});

  $IngredientCopyWith<$Res>? get ingredient;
}

/// @nodoc
class _$RecipeIngredientCopyWithImpl<$Res, $Val extends RecipeIngredient>
    implements $RecipeIngredientCopyWith<$Res> {
  _$RecipeIngredientCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recipeId = null,
    Object? ingredientId = null,
    Object? quantity = null,
    Object? quantityType = null,
    Object? notes = freezed,
    Object? ingredient = freezed,
  }) {
    return _then(_value.copyWith(
      recipeId: null == recipeId
          ? _value.recipeId
          : recipeId // ignore: cast_nullable_to_non_nullable
              as String,
      ingredientId: null == ingredientId
          ? _value.ingredientId
          : ingredientId // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      quantityType: null == quantityType
          ? _value.quantityType
          : quantityType // ignore: cast_nullable_to_non_nullable
              as Unit,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      ingredient: freezed == ingredient
          ? _value.ingredient
          : ingredient // ignore: cast_nullable_to_non_nullable
              as Ingredient?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $IngredientCopyWith<$Res>? get ingredient {
    if (_value.ingredient == null) {
      return null;
    }

    return $IngredientCopyWith<$Res>(_value.ingredient!, (value) {
      return _then(_value.copyWith(ingredient: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RecipeIngredientImplCopyWith<$Res>
    implements $RecipeIngredientCopyWith<$Res> {
  factory _$$RecipeIngredientImplCopyWith(_$RecipeIngredientImpl value,
          $Res Function(_$RecipeIngredientImpl) then) =
      __$$RecipeIngredientImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'recipe_id') String recipeId,
      @JsonKey(name: 'ingredient_id') String ingredientId,
      double quantity,
      @JsonKey(name: 'quantity_type') Unit quantityType,
      String? notes,
      Ingredient? ingredient});

  @override
  $IngredientCopyWith<$Res>? get ingredient;
}

/// @nodoc
class __$$RecipeIngredientImplCopyWithImpl<$Res>
    extends _$RecipeIngredientCopyWithImpl<$Res, _$RecipeIngredientImpl>
    implements _$$RecipeIngredientImplCopyWith<$Res> {
  __$$RecipeIngredientImplCopyWithImpl(_$RecipeIngredientImpl _value,
      $Res Function(_$RecipeIngredientImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recipeId = null,
    Object? ingredientId = null,
    Object? quantity = null,
    Object? quantityType = null,
    Object? notes = freezed,
    Object? ingredient = freezed,
  }) {
    return _then(_$RecipeIngredientImpl(
      recipeId: null == recipeId
          ? _value.recipeId
          : recipeId // ignore: cast_nullable_to_non_nullable
              as String,
      ingredientId: null == ingredientId
          ? _value.ingredientId
          : ingredientId // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      quantityType: null == quantityType
          ? _value.quantityType
          : quantityType // ignore: cast_nullable_to_non_nullable
              as Unit,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      ingredient: freezed == ingredient
          ? _value.ingredient
          : ingredient // ignore: cast_nullable_to_non_nullable
              as Ingredient?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecipeIngredientImpl implements _RecipeIngredient {
  const _$RecipeIngredientImpl(
      {@JsonKey(name: 'recipe_id') required this.recipeId,
      @JsonKey(name: 'ingredient_id') required this.ingredientId,
      required this.quantity,
      @JsonKey(name: 'quantity_type') required this.quantityType,
      this.notes,
      this.ingredient});

  factory _$RecipeIngredientImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecipeIngredientImplFromJson(json);

  @override
  @JsonKey(name: 'recipe_id')
  final String recipeId;
  @override
  @JsonKey(name: 'ingredient_id')
  final String ingredientId;
  @override
  final double quantity;
  @override
  @JsonKey(name: 'quantity_type')
  final Unit quantityType;
  @override
  final String? notes;
  @override
  final Ingredient? ingredient;

  @override
  String toString() {
    return 'RecipeIngredient(recipeId: $recipeId, ingredientId: $ingredientId, quantity: $quantity, quantityType: $quantityType, notes: $notes, ingredient: $ingredient)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipeIngredientImpl &&
            (identical(other.recipeId, recipeId) ||
                other.recipeId == recipeId) &&
            (identical(other.ingredientId, ingredientId) ||
                other.ingredientId == ingredientId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.quantityType, quantityType) ||
                other.quantityType == quantityType) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.ingredient, ingredient) ||
                other.ingredient == ingredient));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, recipeId, ingredientId, quantity,
      quantityType, notes, ingredient);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecipeIngredientImplCopyWith<_$RecipeIngredientImpl> get copyWith =>
      __$$RecipeIngredientImplCopyWithImpl<_$RecipeIngredientImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecipeIngredientImplToJson(
      this,
    );
  }
}

abstract class _RecipeIngredient implements RecipeIngredient {
  const factory _RecipeIngredient(
      {@JsonKey(name: 'recipe_id') required final String recipeId,
      @JsonKey(name: 'ingredient_id') required final String ingredientId,
      required final double quantity,
      @JsonKey(name: 'quantity_type') required final Unit quantityType,
      final String? notes,
      final Ingredient? ingredient}) = _$RecipeIngredientImpl;

  factory _RecipeIngredient.fromJson(Map<String, dynamic> json) =
      _$RecipeIngredientImpl.fromJson;

  @override
  @JsonKey(name: 'recipe_id')
  String get recipeId;
  @override
  @JsonKey(name: 'ingredient_id')
  String get ingredientId;
  @override
  double get quantity;
  @override
  @JsonKey(name: 'quantity_type')
  Unit get quantityType;
  @override
  String? get notes;
  @override
  Ingredient? get ingredient;
  @override
  @JsonKey(ignore: true)
  _$$RecipeIngredientImplCopyWith<_$RecipeIngredientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RecipeSuggestion _$RecipeSuggestionFromJson(Map<String, dynamic> json) {
  return _RecipeSuggestion.fromJson(json);
}

/// @nodoc
mixin _$RecipeSuggestion {
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<String> get instructions => throw _privateConstructorUsedError;
  List<Map<String, String>> get ingredients =>
      throw _privateConstructorUsedError;
  int get cookingTime => throw _privateConstructorUsedError;
  String get difficulty => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecipeSuggestionCopyWith<RecipeSuggestion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeSuggestionCopyWith<$Res> {
  factory $RecipeSuggestionCopyWith(
          RecipeSuggestion value, $Res Function(RecipeSuggestion) then) =
      _$RecipeSuggestionCopyWithImpl<$Res, RecipeSuggestion>;
  @useResult
  $Res call(
      {String name,
      String description,
      List<String> instructions,
      List<Map<String, String>> ingredients,
      int cookingTime,
      String difficulty});
}

/// @nodoc
class _$RecipeSuggestionCopyWithImpl<$Res, $Val extends RecipeSuggestion>
    implements $RecipeSuggestionCopyWith<$Res> {
  _$RecipeSuggestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? instructions = null,
    Object? ingredients = null,
    Object? cookingTime = null,
    Object? difficulty = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      instructions: null == instructions
          ? _value.instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      ingredients: null == ingredients
          ? _value.ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<Map<String, String>>,
      cookingTime: null == cookingTime
          ? _value.cookingTime
          : cookingTime // ignore: cast_nullable_to_non_nullable
              as int,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecipeSuggestionImplCopyWith<$Res>
    implements $RecipeSuggestionCopyWith<$Res> {
  factory _$$RecipeSuggestionImplCopyWith(_$RecipeSuggestionImpl value,
          $Res Function(_$RecipeSuggestionImpl) then) =
      __$$RecipeSuggestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String description,
      List<String> instructions,
      List<Map<String, String>> ingredients,
      int cookingTime,
      String difficulty});
}

/// @nodoc
class __$$RecipeSuggestionImplCopyWithImpl<$Res>
    extends _$RecipeSuggestionCopyWithImpl<$Res, _$RecipeSuggestionImpl>
    implements _$$RecipeSuggestionImplCopyWith<$Res> {
  __$$RecipeSuggestionImplCopyWithImpl(_$RecipeSuggestionImpl _value,
      $Res Function(_$RecipeSuggestionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? instructions = null,
    Object? ingredients = null,
    Object? cookingTime = null,
    Object? difficulty = null,
  }) {
    return _then(_$RecipeSuggestionImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      instructions: null == instructions
          ? _value._instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      ingredients: null == ingredients
          ? _value._ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<Map<String, String>>,
      cookingTime: null == cookingTime
          ? _value.cookingTime
          : cookingTime // ignore: cast_nullable_to_non_nullable
              as int,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecipeSuggestionImpl implements _RecipeSuggestion {
  const _$RecipeSuggestionImpl(
      {required this.name,
      required this.description,
      required final List<String> instructions,
      required final List<Map<String, String>> ingredients,
      this.cookingTime = 30,
      this.difficulty = 'medium'})
      : _instructions = instructions,
        _ingredients = ingredients;

  factory _$RecipeSuggestionImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecipeSuggestionImplFromJson(json);

  @override
  final String name;
  @override
  final String description;
  final List<String> _instructions;
  @override
  List<String> get instructions {
    if (_instructions is EqualUnmodifiableListView) return _instructions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_instructions);
  }

  final List<Map<String, String>> _ingredients;
  @override
  List<Map<String, String>> get ingredients {
    if (_ingredients is EqualUnmodifiableListView) return _ingredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ingredients);
  }

  @override
  @JsonKey()
  final int cookingTime;
  @override
  @JsonKey()
  final String difficulty;

  @override
  String toString() {
    return 'RecipeSuggestion(name: $name, description: $description, instructions: $instructions, ingredients: $ingredients, cookingTime: $cookingTime, difficulty: $difficulty)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipeSuggestionImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._instructions, _instructions) &&
            const DeepCollectionEquality()
                .equals(other._ingredients, _ingredients) &&
            (identical(other.cookingTime, cookingTime) ||
                other.cookingTime == cookingTime) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      description,
      const DeepCollectionEquality().hash(_instructions),
      const DeepCollectionEquality().hash(_ingredients),
      cookingTime,
      difficulty);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecipeSuggestionImplCopyWith<_$RecipeSuggestionImpl> get copyWith =>
      __$$RecipeSuggestionImplCopyWithImpl<_$RecipeSuggestionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecipeSuggestionImplToJson(
      this,
    );
  }
}

abstract class _RecipeSuggestion implements RecipeSuggestion {
  const factory _RecipeSuggestion(
      {required final String name,
      required final String description,
      required final List<String> instructions,
      required final List<Map<String, String>> ingredients,
      final int cookingTime,
      final String difficulty}) = _$RecipeSuggestionImpl;

  factory _RecipeSuggestion.fromJson(Map<String, dynamic> json) =
      _$RecipeSuggestionImpl.fromJson;

  @override
  String get name;
  @override
  String get description;
  @override
  List<String> get instructions;
  @override
  List<Map<String, String>> get ingredients;
  @override
  int get cookingTime;
  @override
  String get difficulty;
  @override
  @JsonKey(ignore: true)
  _$$RecipeSuggestionImplCopyWith<_$RecipeSuggestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RecipeInstructions _$RecipeInstructionsFromJson(Map<String, dynamic> json) {
  return _RecipeInstructions.fromJson(json);
}

/// @nodoc
mixin _$RecipeInstructions {
  List<RecipeStep> get prep => throw _privateConstructorUsedError;
  List<RecipeStep> get cooking => throw _privateConstructorUsedError;
  List<RecipeStep> get plating => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecipeInstructionsCopyWith<RecipeInstructions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeInstructionsCopyWith<$Res> {
  factory $RecipeInstructionsCopyWith(
          RecipeInstructions value, $Res Function(RecipeInstructions) then) =
      _$RecipeInstructionsCopyWithImpl<$Res, RecipeInstructions>;
  @useResult
  $Res call(
      {List<RecipeStep> prep,
      List<RecipeStep> cooking,
      List<RecipeStep> plating});
}

/// @nodoc
class _$RecipeInstructionsCopyWithImpl<$Res, $Val extends RecipeInstructions>
    implements $RecipeInstructionsCopyWith<$Res> {
  _$RecipeInstructionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? prep = null,
    Object? cooking = null,
    Object? plating = null,
  }) {
    return _then(_value.copyWith(
      prep: null == prep
          ? _value.prep
          : prep // ignore: cast_nullable_to_non_nullable
              as List<RecipeStep>,
      cooking: null == cooking
          ? _value.cooking
          : cooking // ignore: cast_nullable_to_non_nullable
              as List<RecipeStep>,
      plating: null == plating
          ? _value.plating
          : plating // ignore: cast_nullable_to_non_nullable
              as List<RecipeStep>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecipeInstructionsImplCopyWith<$Res>
    implements $RecipeInstructionsCopyWith<$Res> {
  factory _$$RecipeInstructionsImplCopyWith(_$RecipeInstructionsImpl value,
          $Res Function(_$RecipeInstructionsImpl) then) =
      __$$RecipeInstructionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<RecipeStep> prep,
      List<RecipeStep> cooking,
      List<RecipeStep> plating});
}

/// @nodoc
class __$$RecipeInstructionsImplCopyWithImpl<$Res>
    extends _$RecipeInstructionsCopyWithImpl<$Res, _$RecipeInstructionsImpl>
    implements _$$RecipeInstructionsImplCopyWith<$Res> {
  __$$RecipeInstructionsImplCopyWithImpl(_$RecipeInstructionsImpl _value,
      $Res Function(_$RecipeInstructionsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? prep = null,
    Object? cooking = null,
    Object? plating = null,
  }) {
    return _then(_$RecipeInstructionsImpl(
      prep: null == prep
          ? _value._prep
          : prep // ignore: cast_nullable_to_non_nullable
              as List<RecipeStep>,
      cooking: null == cooking
          ? _value._cooking
          : cooking // ignore: cast_nullable_to_non_nullable
              as List<RecipeStep>,
      plating: null == plating
          ? _value._plating
          : plating // ignore: cast_nullable_to_non_nullable
              as List<RecipeStep>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecipeInstructionsImpl implements _RecipeInstructions {
  const _$RecipeInstructionsImpl(
      {required final List<RecipeStep> prep,
      required final List<RecipeStep> cooking,
      required final List<RecipeStep> plating})
      : _prep = prep,
        _cooking = cooking,
        _plating = plating;

  factory _$RecipeInstructionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecipeInstructionsImplFromJson(json);

  final List<RecipeStep> _prep;
  @override
  List<RecipeStep> get prep {
    if (_prep is EqualUnmodifiableListView) return _prep;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_prep);
  }

  final List<RecipeStep> _cooking;
  @override
  List<RecipeStep> get cooking {
    if (_cooking is EqualUnmodifiableListView) return _cooking;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cooking);
  }

  final List<RecipeStep> _plating;
  @override
  List<RecipeStep> get plating {
    if (_plating is EqualUnmodifiableListView) return _plating;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_plating);
  }

  @override
  String toString() {
    return 'RecipeInstructions(prep: $prep, cooking: $cooking, plating: $plating)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipeInstructionsImpl &&
            const DeepCollectionEquality().equals(other._prep, _prep) &&
            const DeepCollectionEquality().equals(other._cooking, _cooking) &&
            const DeepCollectionEquality().equals(other._plating, _plating));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_prep),
      const DeepCollectionEquality().hash(_cooking),
      const DeepCollectionEquality().hash(_plating));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecipeInstructionsImplCopyWith<_$RecipeInstructionsImpl> get copyWith =>
      __$$RecipeInstructionsImplCopyWithImpl<_$RecipeInstructionsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecipeInstructionsImplToJson(
      this,
    );
  }
}

abstract class _RecipeInstructions implements RecipeInstructions {
  const factory _RecipeInstructions(
      {required final List<RecipeStep> prep,
      required final List<RecipeStep> cooking,
      required final List<RecipeStep> plating}) = _$RecipeInstructionsImpl;

  factory _RecipeInstructions.fromJson(Map<String, dynamic> json) =
      _$RecipeInstructionsImpl.fromJson;

  @override
  List<RecipeStep> get prep;
  @override
  List<RecipeStep> get cooking;
  @override
  List<RecipeStep> get plating;
  @override
  @JsonKey(ignore: true)
  _$$RecipeInstructionsImplCopyWith<_$RecipeInstructionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RecipeStep _$RecipeStepFromJson(Map<String, dynamic> json) {
  return _RecipeStep.fromJson(json);
}

/// @nodoc
mixin _$RecipeStep {
  int get step => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int? get time => throw _privateConstructorUsedError;
  List<String>? get tools => throw _privateConstructorUsedError;
  String? get temperature => throw _privateConstructorUsedError;
  String? get indicators => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecipeStepCopyWith<RecipeStep> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeStepCopyWith<$Res> {
  factory $RecipeStepCopyWith(
          RecipeStep value, $Res Function(RecipeStep) then) =
      _$RecipeStepCopyWithImpl<$Res, RecipeStep>;
  @useResult
  $Res call(
      {int step,
      String description,
      int? time,
      List<String>? tools,
      String? temperature,
      String? indicators});
}

/// @nodoc
class _$RecipeStepCopyWithImpl<$Res, $Val extends RecipeStep>
    implements $RecipeStepCopyWith<$Res> {
  _$RecipeStepCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? step = null,
    Object? description = null,
    Object? time = freezed,
    Object? tools = freezed,
    Object? temperature = freezed,
    Object? indicators = freezed,
  }) {
    return _then(_value.copyWith(
      step: null == step
          ? _value.step
          : step // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int?,
      tools: freezed == tools
          ? _value.tools
          : tools // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      temperature: freezed == temperature
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as String?,
      indicators: freezed == indicators
          ? _value.indicators
          : indicators // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecipeStepImplCopyWith<$Res>
    implements $RecipeStepCopyWith<$Res> {
  factory _$$RecipeStepImplCopyWith(
          _$RecipeStepImpl value, $Res Function(_$RecipeStepImpl) then) =
      __$$RecipeStepImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int step,
      String description,
      int? time,
      List<String>? tools,
      String? temperature,
      String? indicators});
}

/// @nodoc
class __$$RecipeStepImplCopyWithImpl<$Res>
    extends _$RecipeStepCopyWithImpl<$Res, _$RecipeStepImpl>
    implements _$$RecipeStepImplCopyWith<$Res> {
  __$$RecipeStepImplCopyWithImpl(
      _$RecipeStepImpl _value, $Res Function(_$RecipeStepImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? step = null,
    Object? description = null,
    Object? time = freezed,
    Object? tools = freezed,
    Object? temperature = freezed,
    Object? indicators = freezed,
  }) {
    return _then(_$RecipeStepImpl(
      step: null == step
          ? _value.step
          : step // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int?,
      tools: freezed == tools
          ? _value._tools
          : tools // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      temperature: freezed == temperature
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as String?,
      indicators: freezed == indicators
          ? _value.indicators
          : indicators // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecipeStepImpl implements _RecipeStep {
  const _$RecipeStepImpl(
      {required this.step,
      required this.description,
      this.time,
      final List<String>? tools,
      this.temperature,
      this.indicators})
      : _tools = tools;

  factory _$RecipeStepImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecipeStepImplFromJson(json);

  @override
  final int step;
  @override
  final String description;
  @override
  final int? time;
  final List<String>? _tools;
  @override
  List<String>? get tools {
    final value = _tools;
    if (value == null) return null;
    if (_tools is EqualUnmodifiableListView) return _tools;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? temperature;
  @override
  final String? indicators;

  @override
  String toString() {
    return 'RecipeStep(step: $step, description: $description, time: $time, tools: $tools, temperature: $temperature, indicators: $indicators)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipeStepImpl &&
            (identical(other.step, step) || other.step == step) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.time, time) || other.time == time) &&
            const DeepCollectionEquality().equals(other._tools, _tools) &&
            (identical(other.temperature, temperature) ||
                other.temperature == temperature) &&
            (identical(other.indicators, indicators) ||
                other.indicators == indicators));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, step, description, time,
      const DeepCollectionEquality().hash(_tools), temperature, indicators);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecipeStepImplCopyWith<_$RecipeStepImpl> get copyWith =>
      __$$RecipeStepImplCopyWithImpl<_$RecipeStepImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecipeStepImplToJson(
      this,
    );
  }
}

abstract class _RecipeStep implements RecipeStep {
  const factory _RecipeStep(
      {required final int step,
      required final String description,
      final int? time,
      final List<String>? tools,
      final String? temperature,
      final String? indicators}) = _$RecipeStepImpl;

  factory _RecipeStep.fromJson(Map<String, dynamic> json) =
      _$RecipeStepImpl.fromJson;

  @override
  int get step;
  @override
  String get description;
  @override
  int? get time;
  @override
  List<String>? get tools;
  @override
  String? get temperature;
  @override
  String? get indicators;
  @override
  @JsonKey(ignore: true)
  _$$RecipeStepImplCopyWith<_$RecipeStepImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RecipeIngredients _$RecipeIngredientsFromJson(Map<String, dynamic> json) {
  return _RecipeIngredients.fromJson(json);
}

/// @nodoc
mixin _$RecipeIngredients {
  List<IngredientItem> get available => throw _privateConstructorUsedError;
  List<IngredientItem> get missing => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecipeIngredientsCopyWith<RecipeIngredients> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeIngredientsCopyWith<$Res> {
  factory $RecipeIngredientsCopyWith(
          RecipeIngredients value, $Res Function(RecipeIngredients) then) =
      _$RecipeIngredientsCopyWithImpl<$Res, RecipeIngredients>;
  @useResult
  $Res call({List<IngredientItem> available, List<IngredientItem> missing});
}

/// @nodoc
class _$RecipeIngredientsCopyWithImpl<$Res, $Val extends RecipeIngredients>
    implements $RecipeIngredientsCopyWith<$Res> {
  _$RecipeIngredientsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? available = null,
    Object? missing = null,
  }) {
    return _then(_value.copyWith(
      available: null == available
          ? _value.available
          : available // ignore: cast_nullable_to_non_nullable
              as List<IngredientItem>,
      missing: null == missing
          ? _value.missing
          : missing // ignore: cast_nullable_to_non_nullable
              as List<IngredientItem>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecipeIngredientsImplCopyWith<$Res>
    implements $RecipeIngredientsCopyWith<$Res> {
  factory _$$RecipeIngredientsImplCopyWith(_$RecipeIngredientsImpl value,
          $Res Function(_$RecipeIngredientsImpl) then) =
      __$$RecipeIngredientsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<IngredientItem> available, List<IngredientItem> missing});
}

/// @nodoc
class __$$RecipeIngredientsImplCopyWithImpl<$Res>
    extends _$RecipeIngredientsCopyWithImpl<$Res, _$RecipeIngredientsImpl>
    implements _$$RecipeIngredientsImplCopyWith<$Res> {
  __$$RecipeIngredientsImplCopyWithImpl(_$RecipeIngredientsImpl _value,
      $Res Function(_$RecipeIngredientsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? available = null,
    Object? missing = null,
  }) {
    return _then(_$RecipeIngredientsImpl(
      available: null == available
          ? _value._available
          : available // ignore: cast_nullable_to_non_nullable
              as List<IngredientItem>,
      missing: null == missing
          ? _value._missing
          : missing // ignore: cast_nullable_to_non_nullable
              as List<IngredientItem>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecipeIngredientsImpl implements _RecipeIngredients {
  const _$RecipeIngredientsImpl(
      {required final List<IngredientItem> available,
      required final List<IngredientItem> missing})
      : _available = available,
        _missing = missing;

  factory _$RecipeIngredientsImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecipeIngredientsImplFromJson(json);

  final List<IngredientItem> _available;
  @override
  List<IngredientItem> get available {
    if (_available is EqualUnmodifiableListView) return _available;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_available);
  }

  final List<IngredientItem> _missing;
  @override
  List<IngredientItem> get missing {
    if (_missing is EqualUnmodifiableListView) return _missing;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_missing);
  }

  @override
  String toString() {
    return 'RecipeIngredients(available: $available, missing: $missing)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipeIngredientsImpl &&
            const DeepCollectionEquality()
                .equals(other._available, _available) &&
            const DeepCollectionEquality().equals(other._missing, _missing));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_available),
      const DeepCollectionEquality().hash(_missing));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecipeIngredientsImplCopyWith<_$RecipeIngredientsImpl> get copyWith =>
      __$$RecipeIngredientsImplCopyWithImpl<_$RecipeIngredientsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecipeIngredientsImplToJson(
      this,
    );
  }
}

abstract class _RecipeIngredients implements RecipeIngredients {
  const factory _RecipeIngredients(
      {required final List<IngredientItem> available,
      required final List<IngredientItem> missing}) = _$RecipeIngredientsImpl;

  factory _RecipeIngredients.fromJson(Map<String, dynamic> json) =
      _$RecipeIngredientsImpl.fromJson;

  @override
  List<IngredientItem> get available;
  @override
  List<IngredientItem> get missing;
  @override
  @JsonKey(ignore: true)
  _$$RecipeIngredientsImplCopyWith<_$RecipeIngredientsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IngredientItem _$IngredientItemFromJson(Map<String, dynamic> json) {
  return _IngredientItem.fromJson(json);
}

/// @nodoc
mixin _$IngredientItem {
  String get name => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  String get quantityType => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IngredientItemCopyWith<IngredientItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IngredientItemCopyWith<$Res> {
  factory $IngredientItemCopyWith(
          IngredientItem value, $Res Function(IngredientItem) then) =
      _$IngredientItemCopyWithImpl<$Res, IngredientItem>;
  @useResult
  $Res call({String name, double quantity, String quantityType, String? notes});
}

/// @nodoc
class _$IngredientItemCopyWithImpl<$Res, $Val extends IngredientItem>
    implements $IngredientItemCopyWith<$Res> {
  _$IngredientItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? quantity = null,
    Object? quantityType = null,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      quantityType: null == quantityType
          ? _value.quantityType
          : quantityType // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IngredientItemImplCopyWith<$Res>
    implements $IngredientItemCopyWith<$Res> {
  factory _$$IngredientItemImplCopyWith(_$IngredientItemImpl value,
          $Res Function(_$IngredientItemImpl) then) =
      __$$IngredientItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, double quantity, String quantityType, String? notes});
}

/// @nodoc
class __$$IngredientItemImplCopyWithImpl<$Res>
    extends _$IngredientItemCopyWithImpl<$Res, _$IngredientItemImpl>
    implements _$$IngredientItemImplCopyWith<$Res> {
  __$$IngredientItemImplCopyWithImpl(
      _$IngredientItemImpl _value, $Res Function(_$IngredientItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? quantity = null,
    Object? quantityType = null,
    Object? notes = freezed,
  }) {
    return _then(_$IngredientItemImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      quantityType: null == quantityType
          ? _value.quantityType
          : quantityType // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IngredientItemImpl implements _IngredientItem {
  const _$IngredientItemImpl(
      {required this.name,
      required this.quantity,
      required this.quantityType,
      this.notes});

  factory _$IngredientItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$IngredientItemImplFromJson(json);

  @override
  final String name;
  @override
  final double quantity;
  @override
  final String quantityType;
  @override
  final String? notes;

  @override
  String toString() {
    return 'IngredientItem(name: $name, quantity: $quantity, quantityType: $quantityType, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IngredientItemImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.quantityType, quantityType) ||
                other.quantityType == quantityType) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, quantity, quantityType, notes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IngredientItemImplCopyWith<_$IngredientItemImpl> get copyWith =>
      __$$IngredientItemImplCopyWithImpl<_$IngredientItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IngredientItemImplToJson(
      this,
    );
  }
}

abstract class _IngredientItem implements IngredientItem {
  const factory _IngredientItem(
      {required final String name,
      required final double quantity,
      required final String quantityType,
      final String? notes}) = _$IngredientItemImpl;

  factory _IngredientItem.fromJson(Map<String, dynamic> json) =
      _$IngredientItemImpl.fromJson;

  @override
  String get name;
  @override
  double get quantity;
  @override
  String get quantityType;
  @override
  String? get notes;
  @override
  @JsonKey(ignore: true)
  _$$IngredientItemImplCopyWith<_$IngredientItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
