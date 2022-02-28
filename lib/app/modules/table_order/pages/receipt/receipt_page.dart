import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:quiosque/app/core/models/product_model.dart';
import 'package:quiosque/app/core/services/i_printer_service.dart';
import 'package:quiosque/app/core/utils/formatters.dart';
import 'package:quiosque/app/modules/table_order/pages/receipt/widgets/receipt_app_bar_widget.dart';
import 'package:quiosque/app/modules/table_order/pages/receipt/widgets/receipt_header_widget.dart';
import 'package:quiosque/app/modules/table_order/pages/receipt/widgets/receipt_table_content_widget.dart';

import 'widgets/receipt_table_header_widget.dart';
import 'widgets/receipt_total_section_widget.dart';

class ReceiptPage extends StatefulWidget {
  const ReceiptPage({
    Key? key,
    required this.orderProducts,
    required this.tableNumber,
  }) : super(key: key);

  static const String route = '/receipt';

  final List<ProductModel> orderProducts;
  final int tableNumber;

  @override
  _ReceiptPageState createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  late final DateFormat dateFormatter;
  late final NumberFormat moneyFormatterWithoutCurrency;
  late final NumberFormat moneyFormatter;
  late final IPrinterService printerService;

  @override
  void initState() {
    dateFormatter = Formatters.dateFormatter();
    moneyFormatterWithoutCurrency = Formatters.moneyFormatterWithoutSymbol();
    moneyFormatter = Formatters.moneyFormatter();
    printerService = GetIt.I<IPrinterService>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: ReceiptAppBarWidget(
        title: 'Comanda',
        onPrintPressed: () {
          printerService.printReceipt(
            products: widget.orderProducts,
            tableNumber: widget.tableNumber,
          );
        },
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
              ReceiptTableContentWidget(orderProducts: widget.orderProducts),
              const Divider(thickness: 2),
              ReceiptTotalSectionWidget(
                total: moneyFormatter.format(
                  widget.orderProducts.fold<double>(0.0,
                      (previousValue, element) {
                    final double subTotal =
                        previousValue + (element.quantity! * element.price);
                    return subTotal;
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
