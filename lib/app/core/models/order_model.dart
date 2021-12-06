import 'package:json_annotation/json_annotation.dart';
import 'package:quiosque/app/core/models/product_model.dart';

part 'order_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
@_BoolIntConverter()
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

class _BoolIntConverter implements JsonConverter<bool, int> {
  const _BoolIntConverter();

  @override
  bool fromJson(int json) {
    return json == 1;
  }

  @override
  int toJson(bool object) {
    return object ? 1 : 0;
  }
}
