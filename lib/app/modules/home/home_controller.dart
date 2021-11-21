import 'package:injectable/injectable.dart';
import 'package:quiosque/app/core/models/order_model.dart';

@LazySingleton()
class HomeController {
  OrderModel? findActiveOrderByTableNumber(
      List<OrderModel> allActiveOrders, int tableNumber) {
    final List<OrderModel> filteredList = allActiveOrders
        .where((order) => order.tableNumber == tableNumber)
        .toList();
    return filteredList.isEmpty ? null : filteredList.first;
  }
}
