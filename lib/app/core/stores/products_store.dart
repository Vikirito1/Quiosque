import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:quiosque/app/core/data/dtos/product_dto.dart';
import 'package:quiosque/app/core/data/products/i_product_repository.dart';
import 'package:quiosque/app/core/exceptions/sqflite_exceptions.dart';
import 'package:quiosque/app/core/models/product_model.dart';

part 'products_store.g.dart';

@LazySingleton()
class ProductsStore = _ProductsStoreBase with _$ProductsStore;

abstract class _ProductsStoreBase with Store {
  _ProductsStoreBase(this._productRepository);

  final IProductRepository _productRepository;

  @observable
  ObservableList<ProductModel> allProducts = <ProductModel>[].asObservable();

  @observable
  bool isLoading = false;

  @observable
  String? error;

  @action
  Future<void> fetchAllProducts() async {
    try {
      isLoading = true;
      error = null;
      await _fetchAllProducts();
    } on SqfliteException catch (e) {
      error = e.message;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> createNewProduct(ProductDTO newProduct) async {
    try {
      isLoading = true;
      error = null;
      await _productRepository.createProduct(newProduct);
      await _fetchAllProducts();
    } on SqfliteException catch (e) {
      error = e.message;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> updateProduct(ProductDTO updatedProduct) async {
    try {
      isLoading = true;
      error = null;
      await _productRepository.updateProduct(updatedProduct);
      await _fetchAllProducts();
    } on SqfliteException catch (e) {
      error = e.message;
    } finally {
      isLoading = false;
    }
  }

  Future<void> deleteProduct(int productId) async {
    try {
      isLoading = true;
      error = null;
      await _productRepository.deleteProduct(productId);
      await _fetchAllProducts();
    } on SqfliteException catch (e) {
      error = e.message;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> _fetchAllProducts() async {
    final List<ProductModel> results =
        await _productRepository.getAllProducts();
    allProducts = ObservableList.of(results);
  }
}
