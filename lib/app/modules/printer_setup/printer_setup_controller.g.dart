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

  final _$isBluetoothEnabledAtom =
      Atom(name: '_PrinterSetupControllerBase.isBluetoothEnabled');

  @override
  bool get isBluetoothEnabled {
    _$isBluetoothEnabledAtom.reportRead();
    return super.isBluetoothEnabled;
  }

  @override
  set isBluetoothEnabled(bool value) {
    _$isBluetoothEnabledAtom.reportWrite(value, super.isBluetoothEnabled, () {
      super.isBluetoothEnabled = value;
    });
  }

  final _$isConnectedAtom =
      Atom(name: '_PrinterSetupControllerBase.isConnected');

  @override
  bool get isConnected {
    _$isConnectedAtom.reportRead();
    return super.isConnected;
  }

  @override
  set isConnected(bool value) {
    _$isConnectedAtom.reportWrite(value, super.isConnected, () {
      super.isConnected = value;
    });
  }

  final _$selectedPrinterAtom =
      Atom(name: '_PrinterSetupControllerBase.selectedPrinter');

  @override
  BluetoothPrinterModel? get selectedPrinter {
    _$selectedPrinterAtom.reportRead();
    return super.selectedPrinter;
  }

  @override
  set selectedPrinter(BluetoothPrinterModel? value) {
    _$selectedPrinterAtom.reportWrite(value, super.selectedPrinter, () {
      super.selectedPrinter = value;
    });
  }

  final _$scanPrintersAsyncAction =
      AsyncAction('_PrinterSetupControllerBase.scanPrinters');

  @override
  Future<void> scanPrinters() {
    return _$scanPrintersAsyncAction.run(() => super.scanPrinters());
  }

  final _$setIsBluetoothEnabledAsyncAction =
      AsyncAction('_PrinterSetupControllerBase.setIsBluetoothEnabled');

  @override
  Future<void> setIsBluetoothEnabled() {
    return _$setIsBluetoothEnabledAsyncAction
        .run(() => super.setIsBluetoothEnabled());
  }

  final _$onPrinterSelectedAsyncAction =
      AsyncAction('_PrinterSetupControllerBase.onPrinterSelected');

  @override
  Future<void> onPrinterSelected(BluetoothPrinterModel value) {
    return _$onPrinterSelectedAsyncAction
        .run(() => super.onPrinterSelected(value));
  }

  final _$checkLastUsedPrinterAsyncAction =
      AsyncAction('_PrinterSetupControllerBase.checkLastUsedPrinter');

  @override
  Future<void> checkLastUsedPrinter() {
    return _$checkLastUsedPrinterAsyncAction
        .run(() => super.checkLastUsedPrinter());
  }

  final _$_PrinterSetupControllerBaseActionController =
      ActionController(name: '_PrinterSetupControllerBase');

  @override
  void onRefreshPressed() {
    final _$actionInfo = _$_PrinterSetupControllerBaseActionController
        .startAction(name: '_PrinterSetupControllerBase.onRefreshPressed');
    try {
      return super.onRefreshPressed();
    } finally {
      _$_PrinterSetupControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
scannedPrinters: ${scannedPrinters},
isSearching: ${isSearching},
isBluetoothEnabled: ${isBluetoothEnabled},
isConnected: ${isConnected},
selectedPrinter: ${selectedPrinter}
    ''';
  }
}
