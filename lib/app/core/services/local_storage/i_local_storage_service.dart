import 'package:quiosque/app/core/models/bluetooth_printer_model.dart';

abstract class ILocalStorageService {
  Future<bool> storeLastUsedPrinter(BluetoothPrinterModel selectedPrinter);
  Future<BluetoothPrinterModel?> getLastUsedPrinter();
}
