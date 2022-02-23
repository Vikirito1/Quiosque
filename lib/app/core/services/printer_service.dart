import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:injectable/injectable.dart';
import 'package:quiosque/app/core/services/printer/i_bluetooth_printer.dart';

import '../models/product_model.dart';

@LazySingleton()
class PrinterService {
  PrinterService(this._printer);

  final IBluetoothPrinter _printer;

  Future<bool> printReceipt({
    required List<ProductModel> products,
    required String tableNumber,
  }) async {
    List<int> ticket = [];
    // Using default profile
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    //bytes += generator.setGlobalFont(PosFontType.fontA);
    ticket += generator.reset();

    ticket += generator.text(
      'Kiosque Tô na Praia',
      styles: const PosStyles(
        codeTable: 'CP1252',
        align: PosAlign.center,
      ),
    );
    ticket += generator.text(
      '(22) 99937-6220',
      styles: const PosStyles(
        align: PosAlign.center,
      ),
    );
    ticket += generator.text(
      '(22) 99937-6220',
      styles: const PosStyles(
        align: PosAlign.center,
      ),
      linesAfter: 1,
    );
    ticket += generator.text(
      'Data: ${DateTime.now().toLocal()}',
      linesAfter: 1,
    );
    ticket += generator.hr();
    ticket += generator.row([
      PosColumn(text: 'Qtd', width: 1),
      PosColumn(text: 'Descrição', width: 7),
      PosColumn(text: 'Valor Unit.', width: 2),
      PosColumn(text: 'Total', width: 2),
    ]);
    ticket += generator.hr();
    for (ProductModel product in products) {
      ticket += generator.row([
        PosColumn(text: product.quantity.toString(), width: 1),
        PosColumn(text: product.product, width: 7),
        PosColumn(text: product.price.toStringAsFixed(2), width: 2),
        PosColumn(
          text: (product.price * product.quantity!).toStringAsFixed(2),
          width: 2,
        ),
      ]);
    }
    ticket += generator.hr();
    ticket += generator.row([
      PosColumn(
        text: 'Total',
        width: 6,
        styles: const PosStyles(
          bold: true,
        ),
      ),
      PosColumn(
        text: products.fold<double>(0.0, (previousValue, element) {
          final double subTotal =
              previousValue + (element.quantity! * element.price);
          return subTotal;
        }).toStringAsFixed(2),
        styles: const PosStyles(
          align: PosAlign.right,
          bold: true,
        ),
      ),
    ]);
    ticket += generator.hr();

    ticket += generator.feed(2);
    return _printer.printTicket(ticket);
  }
}
