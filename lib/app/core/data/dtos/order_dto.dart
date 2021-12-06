import 'package:quiosque/app/core/data/dtos/order_product_dto.dart';

class OrderDTO {
  OrderDTO({
    this.id,
    required this.tableNumber,
    this.isOpened = false,
    required this.products,
  });

  final int? id;
  final int tableNumber;
  final bool isOpened;
  final List<OrderProductDTO> products;
}
