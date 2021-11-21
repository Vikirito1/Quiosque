import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:quiosque/app/core/data/orders/i_orders_repository.dart';
import 'package:quiosque/app/core/models/order_model.dart';
part 'orders_store.g.dart';

@LazySingleton()
class OrdersStore = _OrdersStoreBase with _$OrdersStore;

abstract class _OrdersStoreBase with Store {
  _OrdersStoreBase(this._ordersRepository);

  final IOrdersRepository _ordersRepository;

  @observable
  bool loading = false;

  @observable
  String? error;

  @observable
  ObservableList<OrderModel>? allOrders;

  @action
  Future<void> loadAllActiveOrders() async {
    try {
      loading = true;

      final List<OrderModel> resultsOrders =
          await _ordersRepository.getActiveOrders();
      allOrders = ObservableList.of(resultsOrders);
    } catch (e) {
      error = "lascou";
    } finally {
      loading = false;
    }
  }
}
