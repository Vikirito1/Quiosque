import 'package:quiosque/app/core/models/bluetooth_printer_model.dart';

abstract class IBluetoothPrinter {
  Future<bool> printTicket(List<int> ticket);
  Future<bool> connectToPrinter(String macAddress);
  Future<bool> disconnect();
  Future<List<BluetoothPrinterModel>> findDevices();
  Future<bool> get connectionStatus;
}
