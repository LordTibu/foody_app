import 'package:freezed_annotation/freezed_annotation.dart';
import 'unit.dart';

part 'ingredient.freezed.dart';
part 'ingredient.g.dart';

@freezed
class Ingredient with _$Ingredient {
  const factory Ingredient({
    required String id,
    required String name,
    required double quantity,
    @JsonKey(name: 'quantity_type') required Unit quantityType,
    DateTime? expiration,
    String? notes,
    @JsonKey(name: 'user_id') required String userId,
  }) = _Ingredient;

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);
}