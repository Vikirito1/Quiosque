import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:quiosque/app/core/data/dtos/table_order_page_dto.dart';
import 'package:quiosque/app/core/stores/orders_store.dart';
import 'package:quiosque/app/modules/home/home_controller.dart';
import 'package:quiosque/app/modules/home/widgets/table_widget.dart';
import 'package:quiosque/app/modules/table_order/table_order_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static String route = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final String title = 'Mesas';
  int s = 2;

  static const int _totalMesas = 50;

  final OrdersStore ordersStore = GetIt.I<OrdersStore>();
  final HomeController homeController = GetIt.I<HomeController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ordersStore.loadAllActiveOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(title),
        ),
        body: Observer(
          builder: (_) {
            if (ordersStore.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (ordersStore.error != null) {
              return const Center(
                child: Text('Falha ao Carregar dados!'),
              );
            } else {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                ),
                itemCount: _totalMesas,
                padding: const EdgeInsets.all(20.0),
                itemBuilder: (context, index) => TableWidget(
                  orderModel: homeController.findActiveOrderByTableNumber(
                      ordersStore.allOrders!, index + 1),
                  tableNumber: index + 1,
                  onTableSelected: (orderId) async {
                    final TableOrderPageDTO data = TableOrderPageDTO(
                        tableNumber: index + 1, orderId: orderId);
                    await Navigator.pushNamed(context, TableOrderPage.route,
                        arguments: data);
                    await ordersStore.loadAllActiveOrders();
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
