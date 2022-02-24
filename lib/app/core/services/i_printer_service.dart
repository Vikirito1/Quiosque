import '../models/product_model.dart';

abstract class IPrinterService {
  Future<bool> printReceipt(
      {required List<ProductModel> products, required String tableNumber});
}
