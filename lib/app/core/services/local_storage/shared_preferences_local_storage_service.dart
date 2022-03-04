import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:quiosque/app/core/models/bluetooth_printer_model.dart';
import 'package:quiosque/app/core/services/local_storage/i_local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: ILocalStorageService)
class SharedPreferencesLocalStorageService implements ILocalStorageService {
  final String _printerKey = 'last_printer';

  @override
  Future<BluetoothPrinterModel?> getLastUsedPrinter() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? printerString = preferences.getString(_printerKey);
    if (printerString == null) {
      return null;
    } else {
      final Map<String, dynamic> printerMap = jsonDecode(printerString);
      final BluetoothPrinterModel printerModel =
          BluetoothPrinterModel.fromJson(printerMap);
      return printerModel;
    }
  }

  @override
  Future<bool> storeLastUsedPrinter(
      BluetoothPrinterModel selectedPrinter) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final Map<String, dynamic> printerMap = selectedPrinter.toJson();
    final String printerString = jsonEncode(printerMap);
    final bool result = await preferences.setString(_printerKey, printerString);
    return result;
  }
}
