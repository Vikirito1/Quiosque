import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:injectable/injectable.dart';
import 'package:quiosque/app/core/services/printer/i_bluetooth_printer.dart';

@LazySingleton()
class PrinterService {
  PrinterService(this._printer);

  final IBluetoothPrinter _printer;

  Future<bool> printTicket() async {
    List<int> ticket = [];
    // Using default profile
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    //bytes += generator.setGlobalFont(PosFontType.fontA);
    ticket += generator.reset();

    ticket += generator.text(
      'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ',
      styles: const PosStyles(),
    );
    ticket += generator.text('Special 1: ñÑ àÀ èÈ éÉ üÜ çÇ ôÔ',
        styles: const PosStyles(codeTable: 'CP1252'));
    ticket += generator.text(
      'Special 2: blåbærgrød',
      styles: const PosStyles(codeTable: 'CP1252'),
    );

    ticket += generator.text('Bold text', styles: const PosStyles(bold: true));
    ticket +=
        generator.text('Reverse text', styles: const PosStyles(reverse: true));
    ticket += generator.text('Underlined text',
        styles: const PosStyles(underline: true), linesAfter: 1);
    ticket += generator.text('Align left',
        styles: const PosStyles(align: PosAlign.left));
    ticket += generator.text('Align center',
        styles: const PosStyles(align: PosAlign.center));
    ticket += generator.text('Align right',
        styles: const PosStyles(align: PosAlign.right), linesAfter: 1);

    ticket += generator.row([
      PosColumn(
        text: 'col3',
        width: 3,
        styles: const PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col6',
        width: 6,
        styles: const PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col3',
        width: 3,
        styles: const PosStyles(align: PosAlign.center, underline: true),
      ),
    ]);

    //barcode
    final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
    ticket += generator.barcode(Barcode.upcA(barData));

    //QR code
    ticket += generator.qrcode('example.com');

    ticket += generator.text(
      'Text size 50%',
      styles: const PosStyles(
        fontType: PosFontType.fontB,
      ),
    );
    ticket += generator.text(
      'Text size 100%',
      styles: const PosStyles(
        fontType: PosFontType.fontA,
      ),
    );
    ticket += generator.text(
      'Text size 200%',
      styles: const PosStyles(
        height: PosTextSize.size2,
        width: PosTextSize.size2,
      ),
    );

    ticket += generator.feed(2);
    //bytes += generator.cut();
    return _printer.printTicket(ticket);
  }
}
