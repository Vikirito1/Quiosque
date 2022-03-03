import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:quiosque/app/core/models/bluetooth_printer_model.dart';

import '../../core/services/bluetooth_printer/i_bluetooth_printer_service.dart';

part 'printer_setup_controller.g.dart';

@LazySingleton()
class PrinterSetupController = _PrinterSetupControllerBase
    with _$PrinterSetupController;

abstract class _PrinterSetupControllerBase with Store {
  _PrinterSetupControllerBase(this._printerService);

  final IBluetoothPrinterService _printerService;

  @observable
  ObservableList<BluetoothPrinterModel> scannedPrinters =
      ObservableList<BluetoothPrinterModel>();

  @observable
  bool isSearching = false;

  @action
  Future<void> setScannedPrinters() async {
    isSearching = true;
    final scanResults = await _printerService.findDevices();
    scannedPrinters.clear();
    scannedPrinters.addAll(scanResults);
    isSearching = false;
  }
}
