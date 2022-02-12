import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:quiosque/app/core/data/dtos/product_dto.dart';
import 'package:quiosque/app/core/models/category_model.dart';
import 'package:quiosque/app/core/models/product_model.dart';
import 'package:quiosque/app/core/stores/categories_store.dart';
import 'package:quiosque/app/core/stores/products_store.dart';

part 'product_management_controller.g.dart';

@Injectable()
class ProductManagementController = _ProductManagementControllerBase
    with _$ProductManagementController;

abstract class _ProductManagementControllerBase with Store {
  _ProductManagementControllerBase(this.categoriesStore, this.productsStore);

  final CategoriesStore categoriesStore;
  final ProductsStore productsStore;

  ObservableList<CategoryModel> get allCategories =>
      categoriesStore.allCategories;

  @observable
  int? selectedCategoryId;

  @action
  void setSelectedCategoryId(int? value) {
    selectedCategoryId = value;
  }

  void setSelectedCategoryByName(String categoryName) {
    final CategoryModel selectedCategory = allCategories
        .firstWhere((category) => category.category == categoryName);
    selectedCategoryId = selectedCategory.id;
  }

  Future<void> onConfirmButtonPressed(ProductDTO productDTO) async {
    if (productDTO.id == null) {
      await productsStore.createNewProduct(productDTO);
    } else {
      await productsStore.updateProduct(productDTO);
    }
    await productsStore.fetchAllProducts();
  }

  Future<void> onDeleteButtonPressed(ProductModel productModel) async {
    await productsStore.deleteProduct(productModel.id);
  }
}
