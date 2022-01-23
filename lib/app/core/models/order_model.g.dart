// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      id: json['id'] as int,
      tableNumber: json['table_number'] as int,
      isOpened: const BoolIntConverter().fromJson(json['is_opened'] as int),
      productsOrdered: (json['products_ordered'] as List<dynamic>?)
              ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'table_number': instance.tableNumber,
      'is_opened': const BoolIntConverter().toJson(instance.isOpened),
      'products_ordered': instance.productsOrdered,
    };
