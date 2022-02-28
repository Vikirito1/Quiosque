import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:quiosque/app/core/models/product_model.dart';
import 'package:quiosque/app/core/services/i_printer_service.dart';
import 'package:quiosque/app/core/utils/constants.dart';
import 'package:quiosque/app/core/utils/formatters.dart';

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
      appBar: AppBar(
        title: const Text('Comanda'),
        actions: [
          IconButton(
            onPressed: () {
              printerService.printReceipt(
                products: widget.orderProducts,
                tableNumber: widget.tableNumber,
              );
            },
            icon: const Icon(Icons.print),
          ),
        ],
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
              const Text(
                storeName,
                textAlign: TextAlign.center,
              ),
              const Text(
                storeCnpj,
                textAlign: TextAlign.center,
              ),
              const Text(
                storePhoneNumber,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),
              Text('Data: ${dateFormatter.format(DateTime.now())}'),
              Text('Mesa: ${widget.tableNumber}'),
              const SizedBox(height: 20.0),
              const Divider(thickness: 2),
              Row(
                children: const [
                  Expanded(
                    child: Text(
                      'Qtd',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Text(
                      'Descrição',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    flex: 7,
                  ),
                  Expanded(
                    child: Text(
                      'Vl. Unit.',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    flex: 2,
                  ),
                  Expanded(
                    child: Text(
                      'Total',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    flex: 2,
                  ),
                ],
              ),
              const Divider(thickness: 2),
              ...widget.orderProducts
                  .map((product) => Row(
                        children: [
                          Expanded(
                            child: Text(
                              product.quantity!.toString(),
                            ),
                            flex: 1,
                          ),
                          Expanded(
                            child: Text(product.product),
                            flex: 7,
                          ),
                          Expanded(
                            child: Text(
                              moneyFormatterWithoutCurrency
                                  .format(product.price),
                              textAlign: TextAlign.end,
                            ),
                            flex: 2,
                          ),
                          Expanded(
                            child: Text(
                              moneyFormatterWithoutCurrency
                                  .format(product.price * product.quantity!),
                              textAlign: TextAlign.end,
                            ),
                            flex: 2,
                          ),
                        ],
                      ))
                  .toList(),
              const Divider(thickness: 2),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'VALOR TOTAL',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      moneyFormatter.format(20),
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
