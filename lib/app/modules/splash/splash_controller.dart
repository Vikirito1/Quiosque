import 'package:injectable/injectable.dart';
import 'package:quiosque/app/core/stores/products_store.dart';

@LazySingleton()
class SplashController {
  SplashController(this._productsStore);

  final ProductsStore _productsStore;

  Future<void> initializeDependencies() async {
    await _productsStore.fetchAllProducts();
  }

  @disposeMethod
  void dispose() {}
}
