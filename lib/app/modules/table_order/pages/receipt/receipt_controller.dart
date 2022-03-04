import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/models/product_model.dart';
import '../../../../core/services/bluetooth_printer/i_bluetooth_printer_service.dart';
import '../../../../core/services/receipt_ticket/i_receipt_ticket_service.dart';

part 'receipt_controller.g.dart';

@LazySingleton()
class ReceiptController = _ReceiptControllerBase with _$ReceiptController;

abstract class _ReceiptControllerBase with Store {
  _ReceiptControllerBase(this._receiptService, this._printerService);

  final IReceiptTicketService _receiptService;
  final IBluetoothPrinterService _printerService;

  @observable
  bool isPrinterReady = false;

  @observable
  String? error;

  Future<void> onPrinterPressed({
    required List<ProductModel> orderProducts,
    required int tableNumber,
    required double orderTotal,
  }) async {
    error = null;

    await _getPrinterStatus();
    if (isPrinterReady) {
      final List<int> receipt = await _receiptService.generateReceiptTicket(
        products: orderProducts,
        tableNumber: tableNumber,
        orderTotal: orderTotal,
      );
      _printerService.printTicket(receipt);
    } else {
      error = 'Impressora não conectada';
    }
  }

  @action
  Future<void> _getPrinterStatus() async {
    isPrinterReady = await _printerService.connectionStatus;
  }
}
