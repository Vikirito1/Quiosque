// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../modules/categories/categories_controller.dart' as _i26;
import '../../modules/home/home_controller.dart' as _i4;
import '../../modules/printer_setup/printer_setup_controller.dart' as _i19;
import '../../modules/products/pages/product_management_controller.dart'
    as _i23;
import '../../modules/products/products_controller.dart' as _i24;
import '../../modules/splash/splash_controller.dart' as _i25;
import '../../modules/table_order/pages/receipt/receipt_controller.dart'
    as _i21;
import '../data/categories/categories_repository.dart' as _i8;
import '../data/categories/i_categories_repository.dart' as _i7;
import '../data/orders/i_orders_repository.dart' as _i11;
import '../data/orders/orders_repository.dart' as _i12;
import '../data/products/i_product_repository.dart' as _i13;
import '../data/products/product_repository.dart' as _i14;
import '../database/db_connection.dart' as _i3;
import '../services/bluetooth_printer/i_bluetooth_printer_service.dart' as _i5;
import '../services/bluetooth_printer/thermal_bluetooth_printer_service.dart'
    as _i6;
import '../services/local_storage/i_local_storage_service.dart' as _i9;
import '../services/local_storage/shared_preferences_local_storage_service.dart'
    as _i10;
import '../services/receipt_ticket/i_receipt_ticket_service.dart' as _i15;
import '../services/receipt_ticket/receipt_ticket_service.dart' as _i16;
import '../stores/categories_store.dart' as _i22;
import '../stores/order_products_store.dart' as _i17;
import '../stores/orders_store.dart' as _i18;
import '../stores/products_store.dart'
    as _i20; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.DbConnection>(() => _i3.DbConnection());
  gh.lazySingleton<_i4.HomeController>(() => _i4.HomeController());
  gh.lazySingleton<_i5.IBluetoothPrinterService>(
      () => _i6.ThermalBluetoothPrinterService());
  gh.lazySingleton<_i7.ICategoriesRepository>(
      () => _i8.CategoriesRepository(get<_i3.DbConnection>()));
  gh.lazySingleton<_i9.ILocalStorageService>(
      () => _i10.SharedPreferencesLocalStorageService());
  gh.lazySingleton<_i11.IOrdersRepository>(
      () => _i12.OrdersRepository(get<_i3.DbConnection>()));
  gh.lazySingleton<_i13.IProductRepository>(
      () => _i14.ProductRepository(get<_i3.DbConnection>()));
  gh.lazySingleton<_i15.IReceiptTicketService>(
      () => _i16.ReceiptTicketService());
  gh.lazySingleton<_i17.OrderProductsStore>(() => _i17.OrderProductsStore(
      get<_i13.IProductRepository>(), get<_i11.IOrdersRepository>()));
  gh.lazySingleton<_i18.OrdersStore>(
      () => _i18.OrdersStore(get<_i11.IOrdersRepository>()));
  gh.lazySingleton<_i19.PrinterSetupController>(
      () => _i19.PrinterSetupController(get<_i5.IBluetoothPrinterService>()));
  gh.lazySingleton<_i20.ProductsStore>(
      () => _i20.ProductsStore(get<_i13.IProductRepository>()));
  gh.lazySingleton<_i21.ReceiptController>(() => _i21.ReceiptController(
      get<_i15.IReceiptTicketService>(), get<_i5.IBluetoothPrinterService>()));
  gh.lazySingleton<_i22.CategoriesStore>(
      () => _i22.CategoriesStore(get<_i7.ICategoriesRepository>()));
  gh.factory<_i23.ProductManagementController>(() =>
      _i23.ProductManagementController(
          get<_i22.CategoriesStore>(), get<_i20.ProductsStore>()));
  gh.lazySingleton<_i24.ProductsController>(() => _i24.ProductsController(
      get<_i20.ProductsStore>(), get<_i22.CategoriesStore>()));
  gh.lazySingleton<_i25.SplashController>(
      () => _i25.SplashController(
          get<_i20.ProductsStore>(),
          get<_i13.IProductRepository>(),
          get<_i22.CategoriesStore>(),
          get<_i7.ICategoriesRepository>()),
      dispose: (i) => i.dispose());
  gh.lazySingleton<_i26.CategoriesController>(
      () => _i26.CategoriesController(get<_i22.CategoriesStore>()));
  return get;
}
