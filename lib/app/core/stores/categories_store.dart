import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:quiosque/app/core/data/categories/i_categories_repository.dart';
import 'package:quiosque/app/core/exceptions/sqflite_exceptions.dart';
import 'package:quiosque/app/core/models/category_model.dart';

part 'categories_store.g.dart';

@LazySingleton()
class CategoriesStore = _CategoriesStoreBase with _$CategoriesStore;

abstract class _CategoriesStoreBase with Store {
  _CategoriesStoreBase(this._categoriesRepository);

  final ICategoriesRepository _categoriesRepository;

  @observable
  ObservableList<CategoryModel>? allCategories;

  @observable
  bool isLoading = false;

  @observable
  String? error;

  @action
  Future<void> fetchAllCategories() async {
    try {
      isLoading = true;
      error = null;
      await _fetchAllCategories();
    } on SqfliteException catch (e) {
      error = e.message;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> _fetchAllCategories() async {
    final List<CategoryModel> results =
        await _categoriesRepository.getAllCategories();
    allCategories = ObservableList.of(results);
  }
}
