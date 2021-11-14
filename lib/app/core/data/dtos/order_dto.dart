import 'package:quiosque/app/core/data/dtos/product_dto.dart';

class OrderDTO {
  OrderDTO({
    this.id,
    required this.tableNumber,
    this.status = false,
    required this.products,
  });

  final int? id;
  final int tableNumber;
  final bool status;
  final List<ProductDTO> products;
}
