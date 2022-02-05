import 'package:injectable/injectable.dart';
import 'package:quiosque/app/core/data/dtos/category_dto.dart';
import 'package:quiosque/app/core/models/category_model.dart';
import 'package:quiosque/app/core/stores/categories_store.dart';

@LazySingleton()
class CategoriesController {
  CategoriesController(this.categoriesStore);

  final CategoriesStore categoriesStore;

  Future<void> onEditSavePressed(CategoryDTO categoryDTO) async {
    await categoriesStore.updateCategory(categoryDTO);
  }

  Future<void> onAddSavePressed(CategoryDTO categoryDTO) async {
    await categoriesStore.createNewCategory(categoryDTO);
  }

  Future<void> onDeletePressed(
      CategoryModel categoryModel, bool? isConfirmed) async {
    if (isConfirmed != null && isConfirmed) {
      await categoriesStore.deleteCategory(categoryModel);
    }
  }
}
