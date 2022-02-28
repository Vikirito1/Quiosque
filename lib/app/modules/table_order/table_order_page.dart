import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:quiosque/app/core/data/dtos/order_product_dto.dart';
import 'package:quiosque/app/core/data/dtos/table_order_page_dto.dart';
import 'package:quiosque/app/core/models/product_model.dart';
import 'package:quiosque/app/core/stores/order_products_store.dart';
import 'package:quiosque/app/core/stores/products_store.dart';
import 'package:quiosque/app/modules/table_order/models/receipt_page_arguments_model.dart';
import 'package:quiosque/app/modules/table_order/pages/receipt/receipt_page.dart';
import 'package:quiosque/app/modules/table_order/widgets/add_order_product_widget.dart';
import 'package:quiosque/app/modules/table_order/widgets/no_order_widget.dart';
import 'package:quiosque/app/modules/table_order/widgets/order_widget.dart';

class TableOrderPage extends StatefulWidget {
  const TableOrderPage({Key? key}) : super(key: key);

  static String route = '/table';

  @override
  _TableOrderPageState createState() => _TableOrderPageState();
}

class _TableOrderPageState extends State<TableOrderPage> {
  late final TableOrderPageDTO data;
  late final OrderProductsStore _orderProductsStore;
  late final ProductsStore _productsStore;

  @override
  void didChangeDependencies() {
    data = ModalRoute.of(context)?.settings.arguments as TableOrderPageDTO;
    _orderProductsStore = GetIt.I<OrderProductsStore>();
    _productsStore = GetIt.I<ProductsStore>();
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
        title: Observer(builder: (_) {
          if (_orderProductsStore.orderId == null) {
            return Text('Mesa ${data.tableNumber}');
          } else {
            return Text(
              'Mesa ${data.tableNumber} - R\$ ${_orderProductsStore.tableOrderTotal.toStringAsFixed(2)}',
            );
          }
        }),
        centerTitle: true,
        actions: <Widget>[
          Observer(
            builder: (_) => _orderProductsStore.orderId != null
                ? AddOrderProductWidget(
                    availableProducts: _productsStore.allProducts,
                    selectedProducts: _orderProductsStore.orderProducts,
                    onProductTap: (product) async {
                      await _orderProductsStore.toggleAddRemoveProduct(
                        product,
                        _orderProductsStore.orderId!,
                      );
                    },
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
      body: Center(
        child: Observer(
          builder: (_) {
            if (_orderProductsStore.error != null) {
              return Text(_orderProductsStore.error!);
            } else if (_orderProductsStore.orderId == null) {
              return NoOrderWidget(
                tableNumber: data.tableNumber,
                onOrderCreated: () {
                  _orderProductsStore.createOrder(
                    tableNumber: data.tableNumber,
                  );
                },
              );
            } else {
              final List<ProductModel> orderProducts =
                  _orderProductsStore.orderProducts;
              return OrderWidget(
                orderProducts: orderProducts,
                onQuantityChanged: (productId, quantity) async {
                  final OrderProductDTO updatedProduct = OrderProductDTO(
                    ordersId: _orderProductsStore.orderId!,
                    productsId: productId,
                    quantity: quantity,
                  );
                  await _orderProductsStore.updateOrderProducts(updatedProduct);
                  await _orderProductsStore
                      .fetchOrderProducts(_orderProductsStore.orderId!);
                },
                total: _orderProductsStore.tableOrderTotal,
                onCloseOrder: () {
                  _orderProductsStore.closeOrder();
                },
                onGenerateReceipt: () => Navigator.of(context).pushNamed(
                  ReceiptPage.route,
                  arguments: ReceiptPageArgumentsModel(
                    orderProducts: orderProducts,
                    tableNumber: data.tableNumber,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
