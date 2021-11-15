class ProductDTO {
  ProductDTO({
    this.id,
    required this.product,
    required this.price,
  });

  final int? id;
  final String product;
  final double price;
}
