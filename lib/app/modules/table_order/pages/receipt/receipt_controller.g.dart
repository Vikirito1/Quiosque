// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ReceiptController on _ReceiptControllerBase, Store {
  final _$isPrinterReadyAtom =
      Atom(name: '_ReceiptControllerBase.isPrinterReady');

  @override
  bool get isPrinterReady {
    _$isPrinterReadyAtom.reportRead();
    return super.isPrinterReady;
  }

  @override
  set isPrinterReady(bool value) {
    _$isPrinterReadyAtom.reportWrite(value, super.isPrinterReady, () {
      super.isPrinterReady = value;
    });
  }

  final _$errorAtom = Atom(name: '_ReceiptControllerBase.error');

  @override
  String? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$_getPrinterStatusAsyncAction =
      AsyncAction('_ReceiptControllerBase._getPrinterStatus');

  @override
  Future<void> _getPrinterStatus() {
    return _$_getPrinterStatusAsyncAction.run(() => super._getPrinterStatus());
  }

  @override
  String toString() {
    return '''
isPrinterReady: ${isPrinterReady},
error: ${error}
    ''';
  }
}
