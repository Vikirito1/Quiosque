import '../../models/product_model.dart';

abstract class IReceiptTicketService {
  Future<List<int>> generateReceiptTicket({
    required List<ProductModel> products,
    required int tableNumber,
    required double orderTotal,
  });
}
