// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OrdersStore on _OrdersStoreBase, Store {
  final _$loadingAtom = Atom(name: '_OrdersStoreBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$errorAtom = Atom(name: '_OrdersStoreBase.error');

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

  final _$allOrdersAtom = Atom(name: '_OrdersStoreBase.allOrders');

  @override
  ObservableList<OrderModel>? get allOrders {
    _$allOrdersAtom.reportRead();
    return super.allOrders;
  }

  @override
  set allOrders(ObservableList<OrderModel>? value) {
    _$allOrdersAtom.reportWrite(value, super.allOrders, () {
      super.allOrders = value;
    });
  }

  final _$loadAllActiveOrdersAsyncAction =
      AsyncAction('_OrdersStoreBase.loadAllActiveOrders');

  @override
  Future<void> loadAllActiveOrders() {
    return _$loadAllActiveOrdersAsyncAction
        .run(() => super.loadAllActiveOrders());
  }

  @override
  String toString() {
    return '''
loading: ${loading},
error: ${error},
allOrders: ${allOrders}
    ''';
  }
}
