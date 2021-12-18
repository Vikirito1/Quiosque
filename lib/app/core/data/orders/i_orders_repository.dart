import 'package:quiosque/app/core/data/dtos/order_dto.dart';
import 'package:quiosque/app/core/models/order_model.dart';

abstract class IOrdersRepository {
  Future<List<OrderModel>> getAllOrders();
  Future<int> createOrder(OrderDTO orderDTO);
  Future<int> closeOrder(int orderId);
  Future<int> updateOrder(OrderDTO updatedOrder);
  Future<int> deleteOrder(int orderId);
  Future<List<OrderModel>> getActiveOrders();
}
