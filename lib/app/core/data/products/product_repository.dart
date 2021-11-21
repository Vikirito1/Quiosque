import 'package:injectable/injectable.dart';
import 'package:quiosque/app/core/data/dtos/product_dto.dart';
import 'package:quiosque/app/core/database/db_connection.dart';
import 'package:quiosque/app/core/models/product_model.dart';
import 'package:sqflite/sqflite.dart';

import 'i_product_repository.dart';

@LazySingleton(as: IProductRepository)
class ProductRepository implements IProductRepository {
  ProductRepository(this._connection);

  final DbConnection _connection;

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final Database connection = await _connection.openConnection();
    final results =
        await connection.rawQuery('SELECT id, product, price FROM products');
    return results
        .map((productMap) => ProductModel.fromMap(productMap))
        .toList();
  }

  @override
  Future<ProductModel> getProductById(int id) {
    // TODO: implement getProductById
    throw UnimplementedError();
  }

  @override
  Future<int> createProduct(ProductDTO productDTO) async {
    final Database connection = await _connection.openConnection();
    final int productId = await connection
        .rawInsert('INSERT INTO products(product, price) VALUES (?, ?)', [
      productDTO.product,
      productDTO.price,
    ]);
    return productId;
  }

  @override
  Future<int> deleteProduct(int productId) async {
    final Database connection = await _connection.openConnection();
    final deleteLinesCount = await connection
        .rawDelete('DELETE FROM products WHERE id = ?', [productId]);
    return deleteLinesCount;
  }

  @override
  Future<int> updateProduct(ProductDTO updateProduct) async {
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
  }
}
