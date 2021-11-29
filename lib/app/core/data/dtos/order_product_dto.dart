import 'package:json_annotation/json_annotation.dart';

part 'order_product_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OrderProductDTO {
  OrderProductDTO({
    required this.ordersId,
    required this.productsId,
    required this.quantity,
  });

  final int ordersId;
  final int productsId;
  final int quantity;

  factory OrderProductDTO.fromJson(Map<String, dynamic> json) =>
      _$OrderProductDTOFromJson(json);

  Map<String, dynamic> toJson() => _$OrderProductDTOToJson(this);
}
