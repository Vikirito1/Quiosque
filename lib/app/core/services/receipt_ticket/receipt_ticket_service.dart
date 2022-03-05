import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:quiosque/app/core/utils/constants.dart';
import 'package:quiosque/app/core/utils/formatters.dart';

import '../../extensions/date_time_extensions.dart';
import '../../models/product_model.dart';
import 'i_receipt_ticket_service.dart';

@LazySingleton(as: IReceiptTicketService)
class ReceiptTicketService implements IReceiptTicketService {
  ReceiptTicketService() {
    moneyFormatter = Formatters.moneyFormatter();
    moneyFormatterWithoutSymbol = Formatters.moneyFormatterWithoutSymbol();
  }

  late final NumberFormat moneyFormatter;
  late final NumberFormat moneyFormatterWithoutSymbol;

  static const int _quantityColumnWidth = 1;
  static const int _descriptionColumnWidth = 5;
  static const int _unitaryPriceColumnWidth = 3;
  static const int _subtotalPriceColumnWidth = 3;
  static const int _totalPriceColumnWidth = 6;

  @override
  Future<List<int>> generateReceiptTicket({
    required List<ProductModel> products,
    required int tableNumber,
    required double orderTotal,
  }) async {
    List<int> receipt = [];
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);

    receipt += generator.reset();

    //_generateReceiptHeader(receipt, generator, tableNumber);
    receipt += generator.text(
      storeName,
      styles: const PosStyles(
        codeTable: 'CP1252',
        align: PosAlign.center,
      ),
    );
    receipt += generator.text(
      storePhoneNumber,
      styles: const PosStyles(
        align: PosAlign.center,
      ),
      linesAfter: 1,
    );
    receipt += generator.text(
      'Data: ${DateTime.now().getDateTime()}',
      linesAfter: 1,
    );
    receipt += generator.text(
      'Mesa: $tableNumber',
      styles: const PosStyles(
        bold: true,
      ),
    );

    // _generateReceiptTableHeader(receipt, generator);
    receipt += generator.hr();
    receipt += generator.row([
      PosColumn(
        text: 'Qtd',
        width: _quantityColumnWidth,
        styles: const PosStyles(bold: true, align: PosAlign.left),
      ),
      PosColumn(
        text: 'Descrição',
        width: _descriptionColumnWidth,
        styles: const PosStyles(
            bold: true, codeTable: 'CP1252', align: PosAlign.left),
      ),
      PosColumn(
        text: 'Unit',
        width: _unitaryPriceColumnWidth,
        styles: const PosStyles(bold: true, align: PosAlign.left),
      ),
      PosColumn(
        text: 'Total',
        width: _subtotalPriceColumnWidth,
        styles: const PosStyles(bold: true, align: PosAlign.left),
      ),
    ]);
    receipt += generator.hr();

    // _generateReceiptTableContent(receipt, generator, products);

    for (ProductModel product in products) {
      receipt += generator.row([
        PosColumn(
          text: product.quantity.toString(),
          width: _quantityColumnWidth,
          styles: const PosStyles(align: PosAlign.left),
        ),
        PosColumn(
          text: product.product,
          width: _descriptionColumnWidth,
          styles: const PosStyles(
            codeTable: 'CP1252',
            align: PosAlign.left,
          ),
        ),
        PosColumn(
          text: moneyFormatterWithoutSymbol.format(product.price),
          width: _unitaryPriceColumnWidth,
          styles: const PosStyles(align: PosAlign.left),
        ),
        PosColumn(
          text: moneyFormatterWithoutSymbol
              .format(product.price * product.quantity!),
          width: _subtotalPriceColumnWidth,
          styles: const PosStyles(align: PosAlign.left),
        ),
      ]);
    }

    // _generateReceiptTotalSection(receipt, generator, orderTotal);

    receipt += generator.hr();
    receipt += generator.row([
      PosColumn(
        text: 'Total a pagar',
        width: _totalPriceColumnWidth,
        styles: const PosStyles(
          bold: true,
        ),
      ),
      PosColumn(
        text: moneyFormatter.format(orderTotal),
        styles: const PosStyles(
          align: PosAlign.right,
          bold: true,
        ),
        width: _totalPriceColumnWidth,
      ),
    ]);
    receipt += generator.hr();

    receipt += generator.feed(2);

    return receipt;
  }

  // void _generateReceiptHeader(
  //   List<int> receipt,
  //   Generator generator,
  //   int tableNumber,
  // ) {
  //   receipt += generator.text(
  //     storeName,
  //     styles: const PosStyles(
  //       codeTable: 'CP1252',
  //       align: PosAlign.center,
  //     ),
  //   );
  //   receipt += generator.text(
  //     storeCnpj,
  //     styles: const PosStyles(
  //       align: PosAlign.center,
  //     ),
  //   );
  //   receipt += generator.text(
  //     storePhoneNumber,
  //     styles: const PosStyles(
  //       align: PosAlign.center,
  //     ),
  //     linesAfter: 1,
  //   );
  //   receipt += generator.text(
  //     'Data: ${DateTime.now().getDateTime()}',
  //     linesAfter: 1,
  //   );
  //   receipt += generator.text(
  //     'Mesa: $tableNumber',
  //     styles: const PosStyles(
  //       bold: true,
  //     ),
  //   );
  // }

  // void _generateReceiptTableHeader(List<int> receipt, Generator generator) {
  //   receipt += generator.hr();
  //   receipt += generator.row([
  //     PosColumn(
  //       text: 'Qtd',
  //       width: 1,
  //       styles: const PosStyles(bold: true),
  //     ),
  //     PosColumn(
  //       text: 'Descrição',
  //       width: 7,
  //       styles: const PosStyles(bold: true),
  //     ),
  //     PosColumn(
  //       text: 'Valor Unit.',
  //       width: 2,
  //       styles: const PosStyles(bold: true),
  //     ),
  //     PosColumn(
  //       text: 'Total',
  //       width: 2,
  //       styles: const PosStyles(bold: true),
  //     ),
  //   ]);
  //   receipt += generator.hr();
  // }

  // void _generateReceiptTableContent(
  //   List<int> receipt,
  //   Generator generator,
  //   List<ProductModel> products,
  // ) {
  //   for (ProductModel product in products) {
  //     receipt += generator.row([
  //       PosColumn(text: product.quantity.toString(), width: 1),
  //       PosColumn(text: product.product, width: 7),
  //       PosColumn(
  //         text: moneyFormatterWithoutSymbol.format(product.price),
  //         width: 2,
  //       ),
  //       PosColumn(
  //         text: moneyFormatterWithoutSymbol
  //             .format(product.price * product.quantity!),
  //         width: 2,
  //       ),
  //     ]);
  //   }
  // }

  // void _generateReceiptTotalSection(
  //   List<int> receipt,
  //   Generator generator,
  //   double orderTotal,
  // ) {
  //   receipt += generator.hr();
  //   receipt += generator.row([
  //     PosColumn(
  //       text: 'Total',
  //       width: 6,
  //       styles: const PosStyles(
  //         bold: true,
  //       ),
  //     ),
  //     PosColumn(
  //       text: moneyFormatter.format(orderTotal),
  //       styles: const PosStyles(
  //         align: PosAlign.right,
  //         bold: true,
  //       ),
  //       width: 6,
  //     ),
  //   ]);
  //   receipt += generator.hr();
  // }
}
