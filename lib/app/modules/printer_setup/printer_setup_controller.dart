import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:quiosque/app/core/models/bluetooth_printer_model.dart';
import 'package:quiosque/app/core/services/local_storage/i_local_storage_service.dart';

import '../../core/services/bluetooth_printer/i_bluetooth_printer_service.dart';

part 'printer_setup_controller.g.dart';

@LazySingleton()
class PrinterSetupController = _PrinterSetupControllerBase
    with _$PrinterSetupController;

abstract class _PrinterSetupControllerBase with Store {
  _PrinterSetupControllerBase(this._printerService, this._localStorageService);

  final IBluetoothPrinterService _printerService;
  final ILocalStorageService _localStorageService;

  @observable
  ObservableList<BluetoothPrinterModel> scannedPrinters =
      ObservableList<BluetoothPrinterModel>();

  @observable
  bool isSearching = false;

  @observable
  bool isBluetoothEnabled = false;

  @observable
  bool isConnected = false;

  @observable
  BluetoothPrinterModel? selectedPrinter;

  @action
  Future<void> scanPrinters() async {
    isSearching = true;
    final List<BluetoothPrinterModel> scanResults =
        await _printerService.findDevices();
    scannedPrinters.clear();
    scannedPrinters.addAll(scanResults);
    isSearching = false;
  }

  @action
  Future<void> setIsBluetoothEnabled() async {
    isBluetoothEnabled = await _printerService.isBluetoothEnabled;
  }

  @action
  Future<void> onPrinterSelected(BluetoothPrinterModel value) async {
    final bool connectionResult =
        await _printerService.connectToPrinter(value.macAddress);
    await _localStorageService.storeLastUsedPrinter(value);
    isConnected = connectionResult;
  }

  @action
  void onRefreshPressed() {
    setIsBluetoothEnabled();
    if (isBluetoothEnabled) {
      scanPrinters();
    }
  }

  @action
  Future<void> checkLastUsedPrinter() async {
    final BluetoothPrinterModel? lastUsedPrinter =
        await _localStorageService.getLastUsedPrinter();
    if (lastUsedPrinter != null) {
      selectedPrinter = lastUsedPrinter;
      isConnected = await _printerService.connectionStatus;
    }
  }

  Future<void> onInitState() async {
    await setIsBluetoothEnabled();
    if (isBluetoothEnabled) {
      isSearching = true;
      await checkLastUsedPrinter();
      await scanPrinters();
      isSearching = false;
    }
  }
}
