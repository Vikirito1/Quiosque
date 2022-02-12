// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CategoriesStore on _CategoriesStoreBase, Store {
  final _$allCategoriesAtom = Atom(name: '_CategoriesStoreBase.allCategories');

  @override
  ObservableList<CategoryModel> get allCategories {
    _$allCategoriesAtom.reportRead();
    return super.allCategories;
  }

  @override
  set allCategories(ObservableList<CategoryModel> value) {
    _$allCategoriesAtom.reportWrite(value, super.allCategories, () {
      super.allCategories = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_CategoriesStoreBase.isLoading');

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

  final _$errorAtom = Atom(name: '_CategoriesStoreBase.error');

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

  final _$fetchAllCategoriesAsyncAction =
      AsyncAction('_CategoriesStoreBase.fetchAllCategories');

  @override
  Future<void> fetchAllCategories() {
    return _$fetchAllCategoriesAsyncAction
        .run(() => super.fetchAllCategories());
  }

  final _$_fetchAllCategoriesAsyncAction =
      AsyncAction('_CategoriesStoreBase._fetchAllCategories');

  @override
  Future<void> _fetchAllCategories() {
    return _$_fetchAllCategoriesAsyncAction
        .run(() => super._fetchAllCategories());
  }

  @override
  String toString() {
    return '''
allCategories: ${allCategories},
isLoading: ${isLoading},
error: ${error}
    ''';
  }
}
