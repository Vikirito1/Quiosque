import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:quiosque/app/core/data/categories/i_categories_repository.dart';
import 'package:quiosque/app/core/data/products/i_product_repository.dart';
import 'package:quiosque/app/core/stores/categories_store.dart';
import 'package:quiosque/app/core/stores/products_store.dart';
import 'package:quiosque/app/core/utils/constants.dart';

@LazySingleton()
class SplashController {
  SplashController(this._productsStore, this._productRepository,
      this._categoriesStore, this._categoriesRepository);

  final ProductsStore _productsStore;
  final IProductRepository _productRepository;

  final CategoriesStore _categoriesStore;
  final ICategoriesRepository _categoriesRepository;

  Future<void> initializeDependencies() async {
    await _productsStore.fetchAllProducts();
    await _categoriesStore.fetchAllCategories();
    if (_productsStore.allProducts.isEmpty &&
        _categoriesStore.allCategories.isEmpty) {
      await _categoriesRepository.createMultipleCategories(categoriesData);
      await _productRepository.createMultipleProducts(productData);
      await _categoriesStore.fetchAllCategories();
      await _productsStore.fetchAllProducts();
    }
  }

  @disposeMethod
  void dispose() {
    debugPrint('Splash Controller Disposed');
  }
}
