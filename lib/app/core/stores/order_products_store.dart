import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:quiosque/app/core/data/products/i_product_repository.dart';
import 'package:quiosque/app/core/exceptions/sqflite_exceptions.dart';
import 'package:quiosque/app/core/models/product_model.dart';

part 'order_products_store.g.dart';

@LazySingleton()
class OrderProductsStore = _OrderProductsStoreBase with _$OrderProductsStore;

abstract class _OrderProductsStoreBase with Store {
  _OrderProductsStoreBase(this._productRepository);

  final IProductRepository _productRepository;

  @observable
  ObservableList<ProductModel>? orderProducts;

  @observable
  int? orderId;

  @observable
  bool isLoading = false;

  @observable
  String? error;

  @action
  Future<void> fetchOrderProducts(int orderId) async {
    try {
      isLoading = true;
      error = null;
      final List<ProductModel> results =
          await _productRepository.getProductsByOrderId(orderId);
      orderProducts = ObservableList.of(results);
      isLoading = false;
    } on SqfliteException catch (e) {
      error = e.message;
    }
  }
}
