import '../models/product_model.dart';

class Calculators {
  static double calculateProductsTotal(List<ProductModel> products) {
    return products.fold<double>(0.0, (previousValue, element) {
      final double subTotal =
          previousValue + (element.quantity! * element.price);
      return subTotal;
    });
  }
}
