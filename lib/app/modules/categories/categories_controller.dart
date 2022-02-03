import 'package:injectable/injectable.dart';
import 'package:quiosque/app/core/stores/categories_store.dart';

@LazySingleton()
class CategoriesController {
  CategoriesController(this.categoriesStore);

  final CategoriesStore categoriesStore;

  Future<void> onEditSavePressed() async {}
  Future<void> onAddSavePressed() async {}
}
