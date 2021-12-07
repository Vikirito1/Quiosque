import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:quiosque/app/core/data/dtos/order_dto.dart';
import 'package:quiosque/app/core/data/dtos/order_product_dto.dart';
import 'package:quiosque/app/core/data/orders/i_orders_repository.dart';
import 'package:quiosque/app/core/data/products/i_product_repository.dart';
import 'package:quiosque/app/core/exceptions/sqflite_exceptions.dart';
import 'package:quiosque/app/core/models/product_model.dart';

part 'order_products_store.g.dart';

@Injectable()
class OrderProductsStore = _OrderProductsStoreBase with _$OrderProductsStore;

abstract class _OrderProductsStoreBase with Store {
  _OrderProductsStoreBase(this._productRepository, this._ordersRepository);

  final IProductRepository _productRepository;
  final IOrdersRepository _ordersRepository;

  @observable
  ObservableList<ProductModel> orderProducts = ObservableList<ProductModel>();

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

  @action
  Future<void> updateOrderProducts(OrderProductDTO orderProductDTO) async {
    try {
      isLoading = true;
      error = null;
      await _productRepository.updateProductQuantity(orderProductDTO);
      isLoading = false;
    } on SqfliteException catch (e) {
      error = e.message;
    }
  }

  @action
  void _addProductToSelection(ProductModel product) {
    orderProducts.add(product);
  }

  @action
  void _removeProductFromSelection(ProductModel product) {
    orderProducts.remove(product);
  }

  @action
  Future<void> toggleAddRemoveProduct(
      ProductModel productModel, int orderId) async {
    try {
      isLoading = true;
      if (!orderProducts.contains(productModel)) {
        await _productRepository.addProductToOrder(
          OrderProductDTO(
              ordersId: orderId, productsId: productModel.id, quantity: 0),
        );

        _addProductToSelection(productModel);
      } else {
        await _productRepository.removeProductFromOrder(
            orderId, productModel.id);
        _removeProductFromSelection(productModel);
      }
    } on SqfliteException catch (e) {
      error = e.message;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> createOrder({required int tableNumber}) async {
    final OrderDTO creatingOrder =
        OrderDTO(tableNumber: tableNumber, products: [], isOpened: true);
    orderId = await _ordersRepository.createOrder(creatingOrder);
  }

  @computed
  double get tableOrderTotal => orderProducts
      .map((product) => product.price * product.quantity!)
      .fold(0.0, (previousValue, element) => previousValue + element);
}
