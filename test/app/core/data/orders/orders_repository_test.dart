import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quiosque/app/core/data/dtos/order_dto.dart';
import 'package:quiosque/app/core/data/orders/orders_repository.dart';
import 'package:quiosque/app/core/database/db_connection.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../mocked_data.dart';

class DatabaseMock extends Mock implements Database {}

class DbConnectionMock extends Mock implements DbConnection {}

void main() {
  final dbConnectionMock = DbConnectionMock();
  final databaseMock = DatabaseMock();
  final OrdersRepository ordersRepository = OrdersRepository(dbConnectionMock);

  setUp(() {
    when(() => dbConnectionMock.openConnection())
        .thenAnswer((_) async => databaseMock);
  });
  test('Should return a list of orders', () async {
    when(() => databaseMock.rawQuery(''' 
      SELECT o.id as id,
      o.table_number as table_number,
      o.status as status
      FROM orders as o 
      ''')).thenAnswer((_) async => mockedOrdersList);
    for (var item in mockedOrdersList) {
      when(() => databaseMock.rawQuery(''' 
        SELECT id, product, price, ohp.quantity AS quantity
        FROM products
        JOIN orders_has_products as ohp ON ohp.products_id = id
        WHERE ohp.orders_id = ?;
      ''', [item['id']])).thenAnswer((_) async => []);
    }

    final result = await ordersRepository.getAllOrders();

    expect(result.length, 3);
  });

  test('Should return a list with active orders only', () async {
    final List<Map<String, dynamic>> activeOrders =
        mockedOrdersList.where((orderMap) => orderMap['status'] == 1).toList();
    when(() => databaseMock.rawQuery(''' 
      SELECT o.id as id,
      o.table_number as table_number,
      o.status as status
      FROM orders as o
      WHERE o.status = ?
      ''', [1])).thenAnswer((_) async => activeOrders);

    for (var item in activeOrders) {
      when(() => databaseMock.rawQuery(''' 
        SELECT id, product, price, ohp.quantity AS quantity
        FROM products
        JOIN orders_has_products as ohp ON ohp.products_id = id
        WHERE ohp.orders_id = ?;
      ''', [item['id']])).thenAnswer((_) async => []);
    }

    final result = await ordersRepository.getActiveOrders();

    expect(result.length, 2);
  });

  test('Should return id on order creation', () async {
    when(() => databaseMock.transaction(any()))
        .thenAnswer((_) async => mockedOrdersList.length + 1);
    when(() => databaseMock.rawInsert(any()))
        .thenAnswer((_) async => mockedOrdersList.length + 1);

    final OrderDTO newOrder = OrderDTO(tableNumber: 3, products: []);
    final int result = await ordersRepository.createOrder(newOrder);

    expect(result, mockedOrdersList.length + 1);
  });

  test('Should return number of lines affected by order deletion', () async {
    when(() => databaseMock.rawDelete(any(), [3])).thenAnswer((_) async => 1);

    final int result = await ordersRepository.deleteOrder(3);
    expect(result, 1);
  });

  test('Should return number of lines affected by order update', () async {
    final OrderDTO updatedOrder = OrderDTO(id: 4, tableNumber: 3, products: []);

    when(() => databaseMock.transaction(any())).thenAnswer((_) async => 1);
    when(() => databaseMock.rawUpdate(any(), [
          updatedOrder.tableNumber,
          updatedOrder.isOpened ? 1 : 0,
          updatedOrder.id,
        ])).thenAnswer((_) async => 1);
    when(() => databaseMock.rawDelete(any(), [updatedOrder.id]))
        .thenAnswer((_) async => 1);

    final int result = await ordersRepository.updateOrder(updatedOrder);
    expect(result, 1);
  });
}
