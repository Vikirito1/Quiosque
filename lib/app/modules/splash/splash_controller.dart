import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:quiosque/app/core/data/categories/i_categories_repository.dart';
import 'package:quiosque/app/core/data/products/i_product_repository.dart';
import 'package:quiosque/app/core/models/bluetooth_printer_model.dart';
import 'package:quiosque/app/core/services/bluetooth_printer/i_bluetooth_printer_service.dart';
import 'package:quiosque/app/core/services/local_storage/i_local_storage_service.dart';
import 'package:quiosque/app/core/stores/categories_store.dart';
import 'package:quiosque/app/core/stores/products_store.dart';
import 'package:quiosque/app/core/utils/constants.dart';

import '../../core/utils/bluetooth_permission_handler.dart';

@LazySingleton()
class SplashController {
  SplashController(
    this._productsStore,
    this._productRepository,
    this._categoriesStore,
    this._categoriesRepository,
    this._storageService,
    this._printerService,
  );

  final ProductsStore _productsStore;
  final IProductRepository _productRepository;

  final CategoriesStore _categoriesStore;
  final ICategoriesRepository _categoriesRepository;

  final ILocalStorageService _storageService;
  final IBluetoothPrinterService _printerService;

  Future<void> initializeDependencies() async {
    await _productsStore.fetchAllProducts();
    await _categoriesStore.fetchAllCategories();
    if (_productsStore.allProducts.isEmpty &&
        _categoriesStore.allCategories.isEmpty) {
      await _categoriesRepository.createMultipleCategories(categoriesData);
      await _productRepository.createMultipleProducts(productData);
      await _categoriesStore.fetchAllCategories();
      await _productsStore.fetchAllProducts();
    }

    final bool isBluetoothPermissionGranted =
        await BluetoothPermissionHandler.checkPermission();

    if (!isBluetoothPermissionGranted) {
      await BluetoothPermissionHandler.requestBluetoothConnectPermission();
    }

    final BluetoothPrinterModel? lastUsedPrinter =
        await _storageService.getLastUsedPrinter();
    final bool isBluetoothEnabled = await _printerService.isBluetoothEnabled;
    if (lastUsedPrinter != null && isBluetoothEnabled) {
      await _printerService.connectToPrinter(lastUsedPrinter.macAddress);
    }
  }

  @disposeMethod
  void dispose() {
    debugPrint('Splash Controller Disposed');
  }
}
