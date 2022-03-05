import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:quiosque/app/core/models/bluetooth_printer_model.dart';
import 'package:quiosque/app/modules/printer_setup/printer_setup_controller.dart';

import '../../core/widgets/menu_drawer_widget.dart';

class PrinterSetupPage extends StatefulWidget {
  const PrinterSetupPage({
    Key? key,
    this.fromSnackbar,
  }) : super(key: key);

  static const String route = '/printer';
  final bool? fromSnackbar;

  @override
  _PrinterSetupPageState createState() => _PrinterSetupPageState();
}

class _PrinterSetupPageState extends State<PrinterSetupPage> {
  late final PrinterSetupController controller;

  @override
  void initState() {
    controller = GetIt.I<PrinterSetupController>();
    controller.onInitState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações de impressão'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: controller.onRefreshPressed,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      drawer: widget.fromSnackbar == null
          ? const MenuDrawerWidget(routeName: PrinterSetupPage.route)
          : null,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.selectedPrinter != null
                  ? 'Conectado a: ${controller.selectedPrinter?.name}'
                  : 'Nenhuma impressora conectada',
            ),
            Expanded(
              child: Observer(
                builder: (_) {
                  if (!controller.isBluetoothEnabled) {
                    return const Center(
                      child: Text(
                        'Bluetooth desativado. Por favor, ative-o para prosseguir.',
                      ),
                    );
                  } else if (controller.isSearching) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (controller.scannedPrinters.isEmpty) {
                    return const Center(
                      child: Text('Nenhuma impressora encontrada'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: controller.scannedPrinters.length,
                      itemBuilder: (_, index) {
                        final BluetoothPrinterModel printer =
                            controller.scannedPrinters[index];
                        return ListTile(
                          title: Text(printer.name),
                          onTap: () => controller.onPrinterSelected(printer),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search),
        onPressed: controller.scanPrinters,
      ),
    );
  }
}
