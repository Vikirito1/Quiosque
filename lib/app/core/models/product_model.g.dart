// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'] as int,
      product: json['product'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] as int? ?? 1,
      shownInMenu:
          const BoolIntConverter().fromJson(json['shown_in_menu'] as int),
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product': instance.product,
      'price': instance.price,
      'quantity': instance.quantity,
      'shown_in_menu': const BoolIntConverter().toJson(instance.shownInMenu),
    };
