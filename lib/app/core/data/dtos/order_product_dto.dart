class OrderProductDTO {
  OrderProductDTO({
    required this.orderId,
    required this.productId,
    required this.quantity,
  });

  final int orderId;
  final int productId;
  final int quantity;
}
