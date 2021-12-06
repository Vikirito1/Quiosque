import 'package:injectable/injectable.dart';
import 'package:quiosque/app/core/data/dtos/order_dto.dart';
import 'package:quiosque/app/core/data/orders/i_orders_repository.dart';
import 'package:quiosque/app/core/database/db_connection.dart';
import 'package:quiosque/app/core/models/order_model.dart';
import 'package:sqflite/sqflite.dart';

@LazySingleton(as: IOrdersRepository)
class OrdersRepository implements IOrdersRepository {
  OrdersRepository(this._connection);

  final DbConnection _connection;

  @override
  Future<List<OrderModel>> getAllOrders() async {
    final Database connection = await _connection.openConnection();
    final orderResults = await connection.rawQuery(''' 
      SELECT o.id as id,
      o.table_number as table_number,
      o.is_opened as is_opened
      FROM orders as o 
      ''');

    List<OrderModel> allOrders =
        orderResults.map((orderMap) => OrderModel.fromJson(orderMap)).toList();
    return allOrders;
  }

  @override
  Future<int> createOrder(OrderDTO orderDTO) async {
    final Database connection = await _connection.openConnection();
    final int orderId = await connection.rawInsert(
        'INSERT INTO orders(table_number, is_opened) VALUES (?, ?)', [
      orderDTO.tableNumber,
      orderDTO.isOpened ? 1 : 0,
    ]);
    return orderId;
  }

  @override
  Future<int> deleteOrder(int orderId) async {
    final Database connection = await _connection.openConnection();
    final deletedLinesCount = await connection
        .rawDelete('DELETE FROM orders WHERE id = ?', [orderId]);
    return deletedLinesCount;
  }

  @override
  Future<int> updateOrder(OrderDTO updatedOrder) async {
    final Database connection = await _connection.openConnection();

    final int updatedOrdersCount = await connection.transaction((txn) async {
      int count = await txn.rawUpdate('''
        UPDATE orders
        SET table_number = ?, is_opened = ?
        WHERE id = ?
      ''', [
        updatedOrder.tableNumber,
        updatedOrder.isOpened ? 1 : 0,
        updatedOrder.id,
      ]);
      await txn.rawDelete('DELETE FROM orders_has_products WHERE orders_id = ?',
          [updatedOrder.id]);
      for (var productDTO in updatedOrder.products) {
        await txn.rawInsert('''
          INSERT INTO orders_has_products(orders_id, products_id, quantity) VALUES (?, ?, ?)
        ''', [
          updatedOrder.id,
          productDTO.productsId,
          productDTO.quantity,
        ]);
      }
      return count;
    });
    return updatedOrdersCount;
  }

  @override
  Future<List<OrderModel>> getActiveOrders() async {
    final Database connection = await _connection.openConnection();
    final orderResults = await connection.rawQuery(''' 
      SELECT o.id as id,
      o.table_number as table_number,
      o.is_opened as is_opened
      FROM orders as o
      WHERE o.is_opened = ?
      ''', [1]);

    List<OrderModel> allActiveOrders =
        orderResults.map((orderMap) => OrderModel.fromJson(orderMap)).toList();
    return allActiveOrders;
  }
}
