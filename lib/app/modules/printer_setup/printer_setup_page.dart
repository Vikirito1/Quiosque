import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:quiosque/app/modules/printer_setup/printer_setup_controller.dart';

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
      body: Container(),
    );
  }
}
