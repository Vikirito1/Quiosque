import 'package:injectable/injectable.dart';
import 'package:quiosque/app/core/data/dtos/order_product_dto.dart';
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
    final Database connection = await _connection.openConnection();
    try {
      final results =
          await connection.rawQuery('SELECT id, product, price FROM products');
      return results
          .map((productMap) => ProductModel.fromJson(productMap))
          .toList();
    } on DatabaseException catch (e) {
      throw SqfliteExceptionHandler.handleException(e);
    } finally {
      await connection.close();
    }
  }

  @override
  Future<ProductModel> getProductById(int id) {
    // TODO: implement getProductById
    throw UnimplementedError();
  }

  @override
  Future<int> createProduct(ProductDTO productDTO) async {
    final Database connection = await _connection.openConnection();
    try {
      final int productId = await connection
          .rawInsert('INSERT INTO products(product, price) VALUES (?, ?)', [
        productDTO.product,
        productDTO.price,
      ]);
      return productId;
    } on DatabaseException catch (e) {
      throw SqfliteExceptionHandler.handleException(e);
    } finally {
      await connection.close();
    }
  }

  @override
  Future<int> deleteProduct(int productId) async {
    final Database connection = await _connection.openConnection();
    try {
      final deleteLinesCount = await connection
          .rawDelete('DELETE FROM products WHERE id = ?', [productId]);
      return deleteLinesCount;
    } on DatabaseException catch (e) {
      throw SqfliteExceptionHandler.handleException(e);
    } finally {
      await connection.close();
    }
  }

  @override
  Future<int> updateProduct(ProductDTO updateProduct) async {
    final Database connection = await _connection.openConnection();
    try {
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
    } finally {
      await connection.close();
    }
  }

  @override
  Future<List<ProductModel>> getProductsByOrderId(int orderId) async {
    final Database connection = await _connection.openConnection();
    try {
      final List<Map<String, dynamic>> productsFromOrder =
          await connection.rawQuery('''
            SELECT p.id AS id, p.product AS product, p.price AS price, ohp.quantity AS quantity
            FROM products p
            JOIN orders_has_products ohp
            ON ohp.products_id = p.id
            WHERE ohp.orders_id = ?
          ''', [orderId]);
      return productsFromOrder
          .map((productMap) => ProductModel.fromJson(productMap))
          .toList();
    } on DatabaseException catch (e) {
      throw SqfliteExceptionHandler.handleException(e);
    } finally {
      await connection.close();
    }
  }

  @override
  Future<int> updateProductQuantity(OrderProductDTO orderProductDTO) async {
    final Database connection = await _connection.openConnection();
    try {
      final int affectedLines = await connection.rawUpdate('''
        UPDATE orders_has_products
        SET quantity = ?
        WHERE orders_id = ? AND products_id = ?
      ''', [
        orderProductDTO.quantity,
        orderProductDTO.ordersId,
        orderProductDTO.productsId
      ]);
      return affectedLines;
    } on DatabaseException catch (e) {
      throw SqfliteExceptionHandler.handleException(e);
    } finally {
      await connection.close();
    }
  }

  @override
  Future<int> addProductToOrder(OrderProductDTO product) async {
    final Database connection = await _connection.openConnection();
    try {
      final int result = await connection.insert(
        'orders_has_products',
        product.toJson(),
      );
      return result;
    } on DatabaseException catch (e) {
      throw SqfliteExceptionHandler.handleException(e);
    } finally {
      await connection.close();
    }
  }

  @override
  Future<int> removeProductFromOrder(int orderId, int productId) async {
    final Database connection = await _connection.openConnection();
    try {
      final int affectedRows = await connection.delete(
        'orders_has_products',
        where: 'orders_id = ? AND products_id = ?',
        whereArgs: [orderId, productId],
      );
      return affectedRows;
    } on DatabaseException catch (e) {
      throw SqfliteExceptionHandler.handleException(e);
    } finally {
      await connection.close();
    }
  }
}
