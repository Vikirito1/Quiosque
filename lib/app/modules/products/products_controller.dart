import 'package:injectable/injectable.dart';
import 'package:quiosque/app/core/stores/categories_store.dart';
import 'package:quiosque/app/core/stores/products_store.dart';

@LazySingleton()
class ProductsController {
  ProductsController(this.productsStore, this.categoriesStore);

  final ProductsStore productsStore;
  final CategoriesStore categoriesStore;
}
