import 'package:quiosque/app/core/data/dtos/order_dto.dart';
import 'package:quiosque/app/core/data/orders/i_orders_repository.dart';
import 'package:quiosque/app/core/database/db_connection.dart';
import 'package:quiosque/app/core/models/order_model.dart';
import 'package:quiosque/app/core/models/product_model.dart';
import 'package:sqflite/sqflite.dart';

class OrdersRepository implements IOrdersRepository {
  OrdersRepository(this._connection);

  final DbConnection _connection;

  @override
  Future<List<OrderModel>> getAllOrders() async {
    final Database connection = await _connection.openConnection();
    final orderResults = await connection.rawQuery(''' 
      SELECT o.id as id,
      o.table_number as table_number,
      o.status as status,
      FROM orders as o 
      ''');

    List<OrderModel> allOrders = orderResults
        .map(
          (orderMap) => OrderModel(
            id: orderMap['id'] as int,
            tableNumber: orderMap['table_number'] as int,
            status: (orderMap['status'] as int) == 1,
            productsOrdered: [],
          ),
        )
        .toList();
    for (var order in allOrders) {
      final productsResult = await connection.rawQuery(''' 
        SELECT id, product, price
        FROM products
        JOIN orders_has_products as ohp ON ohp.products_id = id
        WHERE ohp.orders_id = ?;
      ''', [order.id]);
      final orderProducts = productsResult
          .map((productMap) => ProductModel.fromMap(productMap))
          .toList();
      order.productsOrdered.addAll(orderProducts);
    }
    return allOrders;
  }

  @override
  Future<int> createOrder(OrderDTO orderDTO) async {
    final Database connection = await _connection.openConnection();
    late int orderId;
    await connection.transaction((txn) async {
      orderId = await txn
          .rawInsert('INSERT INTO orders(table_number, status) VALUES (?, ?)', [
        orderDTO.tableNumber,
        orderDTO.status ? 1 : 0,
      ]);
      for (var productDTO in orderDTO.products) {
        await txn.rawInsert('''
          INSERT INTO orders_has_products(orders_id, products_id, quantity) VALUES (?, ?, ?)
        ''', [
          orderId,
          productDTO.id,
          productDTO.quantity,
        ]);
      }
    });
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
    late int updatedOrdersCount;
    await connection.transaction((txn) async {
      updatedOrdersCount = await txn.rawUpdate('''
        UPDATE orders
        SET table_number = ?, status = ?
        WHERE id = ?
      ''', [
        updatedOrder.tableNumber,
        updatedOrder.status ? 1 : 0,
        updatedOrder.id,
      ]);
      await txn.rawDelete('DELETE FROM orders_has_products WHERE orders_id = ?',
          [updatedOrder.id]);
      for (var productDTO in updatedOrder.products) {
        await txn.rawInsert('''
          INSERT INTO orders_has_products(orders_id, products_id, quantity) VALUES (?, ?, ?)
        ''', [
          updatedOrder.id,
          productDTO.id,
          productDTO.quantity,
        ]);
      }
    });
    return updatedOrdersCount;
  }
}
