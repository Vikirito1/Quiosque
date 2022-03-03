import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:quiosque/app/core/models/bluetooth_printer_model.dart';
import 'package:quiosque/app/modules/printer_setup/printer_setup_controller.dart';

import '../../core/widgets/menu_drawer_widget.dart';

class PrinterSetupPage extends StatefulWidget {
  const PrinterSetupPage({Key? key}) : super(key: key);

  static const String route = '/printer';

  @override
  _PrinterSetupPageState createState() => _PrinterSetupPageState();
}

class _PrinterSetupPageState extends State<PrinterSetupPage> {
  late final PrinterSetupController controller;

  @override
  void initState() {
    controller = GetIt.I<PrinterSetupController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações de impressão'),
      ),
      drawer: const MenuDrawerWidget(routeName: PrinterSetupPage.route),
      body: Observer(
        builder: (_) {
          if (controller.isSearching) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (controller.scannedPrinters.isEmpty) {
            return const Center(
              child: Text('Nenhuma impressora encontrada'),
            );
          } else {
            return ListView.builder(itemBuilder: (_, index) {
              final BluetoothPrinterModel printer =
                  controller.scannedPrinters[index];
              return ListTile(
                title: Text(printer.name),
              );
            });
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search),
        onPressed: controller.setScannedPrinters,
      ),
    );
  }
}
