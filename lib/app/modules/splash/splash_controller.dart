import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:quiosque/app/core/data/products/i_product_repository.dart';
import 'package:quiosque/app/core/stores/products_store.dart';
import 'package:quiosque/app/core/utils/constants.dart';

@LazySingleton()
class SplashController {
  SplashController(this._productsStore, this._productRepository);

  final ProductsStore _productsStore;
  final IProductRepository _productRepository;

  Future<void> initializeDependencies() async {
    await _productsStore.fetchAllProducts();
    if (_productsStore.allProducts!.isEmpty) {
      await _productRepository.createMultipleProducts(productData);
      await _productsStore.fetchAllProducts();
    }
  }

  @disposeMethod
  void dispose() {
    debugPrint('Splash Controller Disposed');
  }
}
