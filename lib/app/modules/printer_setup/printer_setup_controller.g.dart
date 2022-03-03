// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'printer_setup_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PrinterSetupController on _PrinterSetupControllerBase, Store {
  final _$scannedPrintersAtom =
      Atom(name: '_PrinterSetupControllerBase.scannedPrinters');

  @override
  ObservableList<BluetoothPrinterModel> get scannedPrinters {
    _$scannedPrintersAtom.reportRead();
    return super.scannedPrinters;
  }

  @override
  set scannedPrinters(ObservableList<BluetoothPrinterModel> value) {
    _$scannedPrintersAtom.reportWrite(value, super.scannedPrinters, () {
      super.scannedPrinters = value;
    });
  }

  final _$isSearchingAtom =
      Atom(name: '_PrinterSetupControllerBase.isSearching');

  @override
  bool get isSearching {
    _$isSearchingAtom.reportRead();
    return super.isSearching;
  }

  @override
  set isSearching(bool value) {
    _$isSearchingAtom.reportWrite(value, super.isSearching, () {
      super.isSearching = value;
    });
  }

  final _$setScannedPrintersAsyncAction =
      AsyncAction('_PrinterSetupControllerBase.setScannedPrinters');

  @override
  Future<void> setScannedPrinters() {
    return _$setScannedPrintersAsyncAction
        .run(() => super.setScannedPrinters());
  }

  @override
  String toString() {
    return '''
scannedPrinters: ${scannedPrinters},
isSearching: ${isSearching}
    ''';
  }
}
