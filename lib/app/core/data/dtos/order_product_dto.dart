class OrderProductDTO {
  OrderProductDTO({
    required this.ordersId,
    required this.productsId,
    required this.quantity,
  });

  final int ordersId;
  final int productsId;
  final int quantity;
}
