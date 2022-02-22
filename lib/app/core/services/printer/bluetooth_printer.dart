import 'package:injectable/injectable.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:quiosque/app/core/models/bluetooth_printer_model.dart';

import './i_bluetooth_printer.dart';

@LazySingleton(as: IBluetoothPrinter)
class ThermalBluetoothPrinter implements IBluetoothPrinter {
  @override
  Future<List<BluetoothPrinterModel>> findDevices() async {
    final List<BluetoothInfo> foundDevices =
        await PrintBluetoothThermal.pairedBluetooths;
    final List<BluetoothPrinterModel> foundPrinters = foundDevices
        .map((device) => BluetoothPrinterModel(
              name: device.name,
              macAddress: device.macAdress,
            ))
        .toList();
    return foundPrinters;
  }

  @override
  Future<bool> connectToPrinter(String macAddress) async {
    final bool connectionResult =
        await PrintBluetoothThermal.connect(macPrinterAddress: macAddress);
    return connectionResult;
  }

  @override
  Future<bool> disconnect() async {
    final bool disconnectionStatus = await PrintBluetoothThermal.disconnect;
    return disconnectionStatus;
  }

  @override
  Future<bool> get connectionStatus => PrintBluetoothThermal.connectionStatus;

  @override
  Future<bool> printTicket(List<int> ticket) async {
    final bool printCommandResult =
        await PrintBluetoothThermal.writeBytes(ticket);
    return printCommandResult;
  }
}
