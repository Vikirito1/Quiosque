// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDTO _$ProductDTOFromJson(Map<String, dynamic> json) => ProductDTO(
      id: json['id'] as int?,
      product: json['product'] as String,
      price: (json['price'] as num).toDouble(),
      shownInMenu: json['shown_in_menu'] == null
          ? false
          : const BoolIntConverter().fromJson(json['shown_in_menu'] as int),
    );

Map<String, dynamic> _$ProductDTOToJson(ProductDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product': instance.product,
      'price': instance.price,
      'shown_in_menu': const BoolIntConverter().toJson(instance.shownInMenu),
    };
