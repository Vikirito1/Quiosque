import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:injectable/injectable.dart';
import 'package:quiosque/app/core/services/i_printer_service.dart';
import 'package:quiosque/app/core/services/printer/i_bluetooth_printer.dart';

import '../models/product_model.dart';

@LazySingleton(as: IPrinterService)
class PrinterService implements IPrinterService {
  PrinterService(this._printer);

  final IBluetoothPrinter _printer;

  @override
  Future<bool> printReceipt({
    required List<ProductModel> products,
    required String tableNumber,
  }) async {
    List<int> receipt = [];
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);

    receipt += generator.reset();

    _generateReceiptHeader(receipt, generator, tableNumber);
    _generateReceiptTableHeader(receipt, generator);
    _generateReceiptTableContent(receipt, generator, products);
    _generateReceiptTotalSection(receipt, generator, products);

    receipt += generator.feed(2);
    return _printer.printTicket(receipt);
  }

  void _generateReceiptHeader(
      List<int> receipt, Generator generator, String tableNumber) {
    receipt += generator.text(
      'Kiosque Tô na Praia',
      styles: const PosStyles(
        codeTable: 'CP1252',
        align: PosAlign.center,
      ),
    );
    receipt += generator.text(
      '(22) 99937-6220',
      styles: const PosStyles(
        align: PosAlign.center,
      ),
    );
    receipt += generator.text(
      '(22) 99937-6220',
      styles: const PosStyles(
        align: PosAlign.center,
      ),
      linesAfter: 1,
    );
    receipt += generator.text(
      'Data: ${DateTime.now().toLocal()}',
      linesAfter: 1,
    );
    receipt += generator.text(
      'Mesa: $tableNumber',
      styles: const PosStyles(
        bold: true,
      ),
    );
  }

  void _generateReceiptTableHeader(List<int> receipt, Generator generator) {
    receipt += generator.hr();
    receipt += generator.row([
      PosColumn(
        text: 'Qtd',
        width: 1,
        styles: const PosStyles(bold: true),
      ),
      PosColumn(
        text: 'Descrição',
        width: 7,
        styles: const PosStyles(bold: true),
      ),
      PosColumn(
        text: 'Valor Unit.',
        width: 2,
        styles: const PosStyles(bold: true),
      ),
      PosColumn(
        text: 'Total',
        width: 2,
        styles: const PosStyles(bold: true),
      ),
    ]);
    receipt += generator.hr();
  }

  void _generateReceiptTableContent(
    List<int> receipt,
    Generator generator,
    List<ProductModel> products,
  ) {
    for (ProductModel product in products) {
      receipt += generator.row([
        PosColumn(text: product.quantity.toString(), width: 1),
        PosColumn(text: product.product, width: 7),
        PosColumn(text: product.price.toStringAsFixed(2), width: 2),
        PosColumn(
          text: (product.price * product.quantity!).toStringAsFixed(2),
          width: 2,
        ),
      ]);
    }
  }

  void _generateReceiptTotalSection(
    List<int> receipt,
    Generator generator,
    List<ProductModel> products,
  ) {
    receipt += generator.hr();
    receipt += generator.row([
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
        width: 6,
      ),
    ]);
    receipt += generator.hr();
  }
}
