import 'package:quiosque/app/core/models/product_model.dart';

class ReceiptPageArgumentsModel {
  ReceiptPageArgumentsModel({
    required this.orderProducts,
    required this.tableNumber,
  });

  final List<ProductModel> orderProducts;
  final int tableNumber;
}
