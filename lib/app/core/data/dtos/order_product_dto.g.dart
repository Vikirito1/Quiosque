// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_product_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderProductDTO _$OrderProductDTOFromJson(Map<String, dynamic> json) =>
    OrderProductDTO(
      ordersId: json['orders_id'] as int,
      productsId: json['products_id'] as int,
      quantity: json['quantity'] as int,
    );

Map<String, dynamic> _$OrderProductDTOToJson(OrderProductDTO instance) =>
    <String, dynamic>{
      'orders_id': instance.ordersId,
      'products_id': instance.productsId,
      'quantity': instance.quantity,
    };
