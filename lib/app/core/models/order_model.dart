import 'package:json_annotation/json_annotation.dart';
import 'package:quiosque/app/core/models/product_model.dart';
import 'package:quiosque/app/core/utils/bool_int_converter.dart';

part 'order_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
@BoolIntConverter()
class OrderModel {
  OrderModel({
    required this.id,
    required this.tableNumber,
    required this.isOpened,
    this.productsOrdered = const [],
  });

  final int id;
  final int tableNumber;
  final bool isOpened;
  List<ProductModel> productsOrdered;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
