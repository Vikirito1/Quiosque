// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_management_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProductManagementController on _ProductManagementControllerBase, Store {
  final _$selectedCategoryIdAtom =
      Atom(name: '_ProductManagementControllerBase.selectedCategoryId');

  @override
  int? get selectedCategoryId {
    _$selectedCategoryIdAtom.reportRead();
    return super.selectedCategoryId;
  }

  @override
  set selectedCategoryId(int? value) {
    _$selectedCategoryIdAtom.reportWrite(value, super.selectedCategoryId, () {
      super.selectedCategoryId = value;
    });
  }

  final _$_ProductManagementControllerBaseActionController =
      ActionController(name: '_ProductManagementControllerBase');

  @override
  void setSelectedCategoryId(int? value) {
    final _$actionInfo =
        _$_ProductManagementControllerBaseActionController.startAction(
            name: '_ProductManagementControllerBase.setSelectedCategoryId');
    try {
      return super.setSelectedCategoryId(value);
    } finally {
      _$_ProductManagementControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedCategoryId: ${selectedCategoryId}
    ''';
  }
}
