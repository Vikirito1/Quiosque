import 'package:injectable/injectable.dart';
import 'package:quiosque/app/core/data/dtos/product_dto.dart';
import 'package:quiosque/app/core/database/db_connection.dart';
import 'package:quiosque/app/core/models/product_model.dart';
import 'package:quiosque/app/core/utils/sqflite_exception_handler.dart';
import 'package:sqflite/sqflite.dart';

import 'i_product_repository.dart';

@LazySingleton(as: IProductRepository)
class ProductRepository implements IProductRepository {
  ProductRepository(this._connection);

  final DbConnection _connection;

  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final Database connection = await _connection.openConnection();
      final results =
          await connection.rawQuery('SELECT id, product, price FROM products');
      return results
          .map((productMap) => ProductModel.fromJson(productMap))
          .toList();
    } on DatabaseException catch (e) {
      throw SqfliteExceptionHandler.handleException(e);
    }
  }

  @override
  Future<ProductModel> getProductById(int id) {
    // TODO: implement getProductById
    throw UnimplementedError();
  }

  @override
  Future<int> createProduct(ProductDTO productDTO) async {
    try {
      final Database connection = await _connection.openConnection();
      final int productId = await connection
          .rawInsert('INSERT INTO products(product, price) VALUES (?, ?)', [
        productDTO.product,
        productDTO.price,
      ]);
      return productId;
    } on DatabaseException catch (e) {
      throw SqfliteExceptionHandler.handleException(e);
    }
  }

  @override
  Future<int> deleteProduct(int productId) async {
    try {
      final Database connection = await _connection.openConnection();
      final deleteLinesCount = await connection
          .rawDelete('DELETE FROM products WHERE id = ?', [productId]);
      return deleteLinesCount;
    } on DatabaseException catch (e) {
      throw SqfliteExceptionHandler.handleException(e);
    }
  }

  @override
  Future<int> updateProduct(ProductDTO updateProduct) async {
    try {
      final Database connection = await _connection.openConnection();
      final int updatedProductsCount = await connection.rawUpdate(''' 
        UPDATE products
        SET product = ?, price = ?
        WHERE id = ?
      ''', [
        updateProduct.product,
        updateProduct.price,
        updateProduct.id,
      ]);
      return updatedProductsCount;
    } on DatabaseException catch (e) {
      throw SqfliteExceptionHandler.handleException(e);
    }
  }
}
