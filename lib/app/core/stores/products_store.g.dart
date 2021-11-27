// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProductsStore on _ProductsStoreBase, Store {
  final _$allProductsAtom = Atom(name: '_ProductsStoreBase.allProducts');

  @override
  ObservableList<ProductModel>? get allProducts {
    _$allProductsAtom.reportRead();
    return super.allProducts;
  }

  @override
  set allProducts(ObservableList<ProductModel>? value) {
    _$allProductsAtom.reportWrite(value, super.allProducts, () {
      super.allProducts = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_ProductsStoreBase.isLoading');

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

  final _$errorAtom = Atom(name: '_ProductsStoreBase.error');

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

  final _$fetchAllProductsAsyncAction =
      AsyncAction('_ProductsStoreBase.fetchAllProducts');

  @override
  Future<void> fetchAllProducts() {
    return _$fetchAllProductsAsyncAction.run(() => super.fetchAllProducts());
  }

  final _$createNewProductAsyncAction =
      AsyncAction('_ProductsStoreBase.createNewProduct');

  @override
  Future<void> createNewProduct(ProductDTO newProduct) {
    return _$createNewProductAsyncAction
        .run(() => super.createNewProduct(newProduct));
  }

  final _$updateProductAsyncAction =
      AsyncAction('_ProductsStoreBase.updateProduct');

  @override
  Future<void> updateProduct(ProductDTO updatedProduct) {
    return _$updateProductAsyncAction
        .run(() => super.updateProduct(updatedProduct));
  }

  final _$_fetchAllProductsAsyncAction =
      AsyncAction('_ProductsStoreBase._fetchAllProducts');

  @override
  Future<void> _fetchAllProducts() {
    return _$_fetchAllProductsAsyncAction.run(() => super._fetchAllProducts());
  }

  @override
  String toString() {
    return '''
allProducts: ${allProducts},
isLoading: ${isLoading},
error: ${error}
    ''';
  }
}
