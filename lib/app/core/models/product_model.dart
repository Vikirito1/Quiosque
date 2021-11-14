class ProductModel {
  ProductModel({
    required this.id,
    required this.product,
    required this.price,
    this.quantity,
  });

  final int id;
  final String product;
  final double price;
  final int? quantity;

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      product: map['product'],
      price: map['price'],
      quantity: map['quantity'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product': product,
      'price': price,
      'quantity': quantity,
    };
  }
}
