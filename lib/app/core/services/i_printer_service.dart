import '../models/product_model.dart';

abstract class IPrinterService {
  Future<bool> printReceipt({
    required List<ProductModel> products,
    required int tableNumber,
    required double orderTotal,
  });

  Future<bool> get isPrinterReady;
}
