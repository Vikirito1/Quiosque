// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDTO _$ProductDTOFromJson(Map<String, dynamic> json) => ProductDTO(
      id: json['id'] as int?,
      product: json['product'] as String,
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$ProductDTOToJson(ProductDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product': instance.product,
      'price': instance.price,
    };
