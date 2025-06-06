// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IngredientImpl _$$IngredientImplFromJson(Map<String, dynamic> json) =>
    _$IngredientImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      quantityType: $enumDecode(_$UnitEnumMap, json['quantity_type']),
      expiration: json['expiration'] == null
          ? null
          : DateTime.parse(json['expiration'] as String),
      notes: json['notes'] as String?,
      userId: json['user_id'] as String,
    );

Map<String, dynamic> _$$IngredientImplToJson(_$IngredientImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'quantity': instance.quantity,
      'quantity_type': _$UnitEnumMap[instance.quantityType]!,
      'expiration': instance.expiration?.toIso8601String(),
      'notes': instance.notes,
      'user_id': instance.userId,
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
