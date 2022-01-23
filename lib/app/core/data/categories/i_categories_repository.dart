import 'package:quiosque/app/core/data/dtos/category_dto.dart';
import 'package:quiosque/app/core/models/category_model.dart';

abstract class ICategoriesRepository {
  Future<List<CategoryModel>> getAllCategories();
  Future<int> createCategory(CategoryDTO categoryDTO);
  Future<int> updateCategory(CategoryDTO categoryDTO);
  Future<int> deleteCategory(int categoryId);
  Future<List<int>> createMultipleCategories(List<CategoryDTO> categoriesList);
}
