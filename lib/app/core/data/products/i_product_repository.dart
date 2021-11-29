import 'package:quiosque/app/core/data/dtos/order_product_dto.dart';
import 'package:quiosque/app/core/data/dtos/product_dto.dart';
import 'package:quiosque/app/core/models/product_model.dart';

abstract class IProductRepository {
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel> getProductById(int id);
  Future<int> createProduct(ProductDTO productDTO);
  Future<int> updateProduct(ProductDTO updateProduct);
  Future<int> deleteProduct(int productId);
  Future<List<ProductModel>> getProductsByOrderId(int orderId);
  Future<int> updateProductQuantity(OrderProductDTO orderProductDTO);
  Future<int> addProductToOrder(OrderProductDTO product);
  Future<int> removeProductFromOrder(int orderId, int productId);
}
