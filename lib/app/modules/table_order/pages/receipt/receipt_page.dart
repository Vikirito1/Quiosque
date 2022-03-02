import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:quiosque/app/core/services/i_printer_service.dart';
import 'package:quiosque/app/core/stores/order_products_store.dart';
import 'package:quiosque/app/core/utils/formatters.dart';
import 'package:quiosque/app/modules/table_order/pages/receipt/receipt_controller.dart';
import 'package:quiosque/app/modules/table_order/pages/receipt/widgets/receipt_app_bar_widget.dart';
import 'package:quiosque/app/modules/table_order/pages/receipt/widgets/receipt_header_widget.dart';
import 'package:quiosque/app/modules/table_order/pages/receipt/widgets/receipt_table_content_widget.dart';

import 'widgets/receipt_table_header_widget.dart';
import 'widgets/receipt_total_section_widget.dart';

class ReceiptPage extends StatefulWidget {
  const ReceiptPage({
    Key? key,
    required this.tableNumber,
  }) : super(key: key);

  static const String route = '/receipt';

  final int tableNumber;

  @override
  _ReceiptPageState createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  late final DateFormat dateFormatter;
  late final NumberFormat moneyFormatterWithoutCurrency;
  late final NumberFormat moneyFormatter;
  late final IPrinterService printerService;
  late final OrderProductsStore orderProductsStore;
  late final ReceiptController controller;
  late final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  late final ReactionDisposer printerStatusReactionDisposer;

  @override
  void initState() {
    dateFormatter = Formatters.dateFormatter();
    moneyFormatterWithoutCurrency = Formatters.moneyFormatterWithoutSymbol();
    moneyFormatter = Formatters.moneyFormatter();
    printerService = GetIt.I<IPrinterService>();
    orderProductsStore = GetIt.I<OrderProductsStore>();
    controller = GetIt.I<ReceiptController>();
    scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

    printerStatusReactionDisposer =
        reaction((_) => controller.error != null, _printerStatusReaction);

    super.initState();
  }

  @override
  void dispose() {
    printerStatusReactionDisposer.reaction.dispose();
    super.dispose();
  }

  void _printerStatusReaction(_) {
    if (controller.error != null) {
      final SnackBar errorSnackbar = SnackBar(
        content: Text(controller.error!),
        backgroundColor: Colors.red,
      );
      scaffoldMessengerKey.currentState?.showSnackBar(errorSnackbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(
        appBar: ReceiptAppBarWidget(
          title: 'Comanda',
          onPrintPressed: () => controller.onPrinterPressed(
            orderProducts: orderProductsStore.orderProducts,
            tableNumber: widget.tableNumber,
            orderTotal: orderProductsStore.tableOrderTotal,
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          padding: const EdgeInsets.all(16.0),
          color: Colors.yellow[100],
          width: screenSize.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                ReceiptHeaderWidget(
                  dateAndTime: dateFormatter.format(DateTime.now()),
                  tableNumber: widget.tableNumber,
                ),
                const SizedBox(height: 20.0),
                const Divider(thickness: 2),
                const ReceiptTableHeaderWidget(),
                const Divider(thickness: 2),
                ReceiptTableContentWidget(
                  orderProducts: orderProductsStore.orderProducts,
                ),
                const Divider(thickness: 2),
                ReceiptTotalSectionWidget(
                  total: moneyFormatter.format(
                    orderProductsStore.tableOrderTotal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
