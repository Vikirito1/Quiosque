// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../modules/categories/categories_controller.dart' as _i24;
import '../../modules/home/home_controller.dart' as _i4;
import '../../modules/printer_setup/printer_setup_controller.dart' as _i17;
import '../../modules/products/pages/product_management_controller.dart'
    as _i21;
import '../../modules/products/products_controller.dart' as _i22;
import '../../modules/splash/splash_controller.dart' as _i23;
import '../../modules/table_order/pages/receipt/receipt_controller.dart'
    as _i19;
import '../data/categories/categories_repository.dart' as _i8;
import '../data/categories/i_categories_repository.dart' as _i7;
import '../data/orders/i_orders_repository.dart' as _i9;
import '../data/orders/orders_repository.dart' as _i10;
import '../data/products/i_product_repository.dart' as _i11;
import '../data/products/product_repository.dart' as _i12;
import '../database/db_connection.dart' as _i3;
import '../services/bluetooth_printer/i_bluetooth_printer_service.dart' as _i5;
import '../services/bluetooth_printer/thermal_bluetooth_printer_service.dart'
    as _i6;
import '../services/receipt_ticket/i_receipt_ticket_service.dart' as _i13;
import '../services/receipt_ticket/receipt_ticket_service.dart' as _i14;
import '../stores/categories_store.dart' as _i20;
import '../stores/order_products_store.dart' as _i15;
import '../stores/orders_store.dart' as _i16;
import '../stores/products_store.dart'
    as _i18; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i9.IOrdersRepository>(
      () => _i10.OrdersRepository(get<_i3.DbConnection>()));
  gh.lazySingleton<_i11.IProductRepository>(
      () => _i12.ProductRepository(get<_i3.DbConnection>()));
  gh.lazySingleton<_i13.IReceiptTicketService>(
      () => _i14.ReceiptTicketService());
  gh.lazySingleton<_i15.OrderProductsStore>(() => _i15.OrderProductsStore(
      get<_i11.IProductRepository>(), get<_i9.IOrdersRepository>()));
  gh.lazySingleton<_i16.OrdersStore>(
      () => _i16.OrdersStore(get<_i9.IOrdersRepository>()));
  gh.lazySingleton<_i17.PrinterSetupController>(
      () => _i17.PrinterSetupController(get<_i5.IBluetoothPrinterService>()));
  gh.lazySingleton<_i18.ProductsStore>(
      () => _i18.ProductsStore(get<_i11.IProductRepository>()));
  gh.lazySingleton<_i19.ReceiptController>(() => _i19.ReceiptController(
      get<_i13.IReceiptTicketService>(), get<_i5.IBluetoothPrinterService>()));
  gh.lazySingleton<_i20.CategoriesStore>(
      () => _i20.CategoriesStore(get<_i7.ICategoriesRepository>()));
  gh.factory<_i21.ProductManagementController>(() =>
      _i21.ProductManagementController(
          get<_i20.CategoriesStore>(), get<_i18.ProductsStore>()));
  gh.lazySingleton<_i22.ProductsController>(() => _i22.ProductsController(
      get<_i18.ProductsStore>(), get<_i20.CategoriesStore>()));
  gh.lazySingleton<_i23.SplashController>(
      () => _i23.SplashController(
          get<_i18.ProductsStore>(),
          get<_i11.IProductRepository>(),
          get<_i20.CategoriesStore>(),
          get<_i7.ICategoriesRepository>()),
      dispose: (i) => i.dispose());
  gh.lazySingleton<_i24.CategoriesController>(
      () => _i24.CategoriesController(get<_i20.CategoriesStore>()));
  return get;
}
