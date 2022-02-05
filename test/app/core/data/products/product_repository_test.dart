import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quiosque/app/core/data/dtos/product_dto.dart';
import 'package:quiosque/app/core/data/products/product_repository.dart';
import 'package:quiosque/app/core/database/db_connection.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../mocked_data.dart';

class DatabaseMock extends Mock implements Database {}

class DbConnectionMock extends Mock implements DbConnection {}

void main() {
  final dbConnectionMock = DbConnectionMock();
  final databaseMock = DatabaseMock();
  final ProductRepository productRepository =
      ProductRepository(dbConnectionMock);

  setUp(() {
    when(() => dbConnectionMock.openConnection())
        .thenAnswer((_) async => databaseMock);
  });

  test('Should return a list of products', () async {
    when(() => databaseMock.rawQuery(any()))
        .thenAnswer((_) async => mockedProductsList);

    final result = await productRepository.getAllProducts();
    expect(result.length, 3);
  });

  test('Should return id when a new product is added', () async {
    final ProductDTO newProduct = ProductDTO(
      product: 'Guaraná Antártica',
      price: 4.99,
      categoriesId: 1,
    );
    when(() => databaseMock
            .rawInsert(any(), [newProduct.product, newProduct.price]))
        .thenAnswer((_) async => 4);

    final result = await productRepository.createProduct(newProduct);
    expect(result, 4);
  });

  test('Should return the number of affected lines when a product is removed',
      () async {
    const int productId = 4;
    when(() => databaseMock.rawDelete(any(), [productId]))
        .thenAnswer((_) async => productId);

    final result = await productRepository.deleteProduct(productId);
    expect(result, productId);
  });

  test('Should return the number of affected lines when a product is updated',
      () async {
    final ProductDTO updatedProduct = ProductDTO(
      product: 'Guaraná Antártica',
      price: 3.99,
      id: 4,
      categoriesId: 1,
    );
    when(() => databaseMock.rawUpdate(any(), [
          updatedProduct.product,
          updatedProduct.price,
          updatedProduct.id,
        ])).thenAnswer((_) async => updatedProduct.id!);

    final int result = await productRepository.updateProduct(updatedProduct);
    expect(result, updatedProduct.id);
  });
}
