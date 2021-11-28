import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:quiosque/app/core/data/dtos/table_order_page_dto.dart';
import 'package:quiosque/app/core/models/product_model.dart';
import 'package:quiosque/app/core/stores/order_products_store.dart';
import 'package:quiosque/app/modules/table_order/widget/order_widget.dart';

class TableOrderPage extends StatefulWidget {
  const TableOrderPage({Key? key}) : super(key: key);

  static String route = '/table';

  @override
  _TableOrderPageState createState() => _TableOrderPageState();
}

class _TableOrderPageState extends State<TableOrderPage> {
  late final TableOrderPageDTO data;
  late final OrderProductsStore _orderProductsStore;

  @override
  void didChangeDependencies() {
    data = ModalRoute.of(context)?.settings.arguments as TableOrderPageDTO;
    _orderProductsStore = GetIt.I<OrderProductsStore>();
    _orderProductsStore.orderId = data.orderId;
    if (data.orderId != null) {
      _orderProductsStore.fetchOrderProducts(data.orderId!);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mesa ${data.tableNumber}'),
      ),
      body: Center(
        child: Observer(
          builder: (_) {
            if (_orderProductsStore.isLoading) {
              return const CircularProgressIndicator();
            } else if (_orderProductsStore.error != null) {
              return Text(_orderProductsStore.error!);
            } else if (_orderProductsStore.orderId == null) {
              return const Text('Mesa fechada');
            } else {
              final List<ProductModel> orderProducts =
                  _orderProductsStore.orderProducts!;
              return OrderWidget(orderProducts: orderProducts);
            }
          },
        ),
      ),
    );
  }
}
