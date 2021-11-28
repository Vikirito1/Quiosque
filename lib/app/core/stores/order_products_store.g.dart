// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_products_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OrderProductsStore on _OrderProductsStoreBase, Store {
  final _$orderProductsAtom =
      Atom(name: '_OrderProductsStoreBase.orderProducts');

  @override
  ObservableList<ProductModel>? get orderProducts {
    _$orderProductsAtom.reportRead();
    return super.orderProducts;
  }

  @override
  set orderProducts(ObservableList<ProductModel>? value) {
    _$orderProductsAtom.reportWrite(value, super.orderProducts, () {
      super.orderProducts = value;
    });
  }

  final _$orderIdAtom = Atom(name: '_OrderProductsStoreBase.orderId');

  @override
  int? get orderId {
    _$orderIdAtom.reportRead();
    return super.orderId;
  }

  @override
  set orderId(int? value) {
    _$orderIdAtom.reportWrite(value, super.orderId, () {
      super.orderId = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_OrderProductsStoreBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$errorAtom = Atom(name: '_OrderProductsStoreBase.error');

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

  final _$fetchOrderProductsAsyncAction =
      AsyncAction('_OrderProductsStoreBase.fetchOrderProducts');

  @override
  Future<void> fetchOrderProducts(int orderId) {
    return _$fetchOrderProductsAsyncAction
        .run(() => super.fetchOrderProducts(orderId));
  }

  final _$updateOrderProductsAsyncAction =
      AsyncAction('_OrderProductsStoreBase.updateOrderProducts');

  @override
  Future<void> updateOrderProducts(OrderProductDTO orderProductDTO) {
    return _$updateOrderProductsAsyncAction
        .run(() => super.updateOrderProducts(orderProductDTO));
  }

  @override
  String toString() {
    return '''
orderProducts: ${orderProducts},
orderId: ${orderId},
isLoading: ${isLoading},
error: ${error}
    ''';
  }
}
