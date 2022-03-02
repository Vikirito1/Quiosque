import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/models/product_model.dart';
import '../../../../core/services/i_printer_service.dart';

part 'receipt_controller.g.dart';

@LazySingleton()
class ReceiptController = _ReceiptControllerBase with _$ReceiptController;

abstract class _ReceiptControllerBase with Store {
  _ReceiptControllerBase(this._printerService);

  final IPrinterService _printerService;

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
      _printerService.printReceipt(
        products: orderProducts,
        tableNumber: tableNumber,
        orderTotal: orderTotal,
      );
    } else {
      error = 'Impressora não conectada';
    }
  }

  @action
  Future<void> _getPrinterStatus() async {
    isPrinterReady = await _printerService.isPrinterReady;
  }
}
