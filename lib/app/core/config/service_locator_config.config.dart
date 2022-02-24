// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../modules/categories/categories_controller.dart' as _i22;
import '../../modules/home/home_controller.dart' as _i4;
import '../../modules/products/pages/product_management_controller.dart'
    as _i19;
import '../../modules/products/products_controller.dart' as _i20;
import '../../modules/splash/splash_controller.dart' as _i21;
import '../data/categories/categories_repository.dart' as _i8;
import '../data/categories/i_categories_repository.dart' as _i7;
import '../data/orders/i_orders_repository.dart' as _i9;
import '../data/orders/orders_repository.dart' as _i10;
import '../data/products/i_product_repository.dart' as _i13;
import '../data/products/product_repository.dart' as _i14;
import '../database/db_connection.dart' as _i3;
import '../services/i_printer_service.dart' as _i11;
import '../services/printer/bluetooth_printer.dart' as _i6;
import '../services/printer/i_bluetooth_printer.dart' as _i5;
import '../services/printer_service.dart' as _i12;
import '../stores/categories_store.dart' as _i18;
import '../stores/order_products_store.dart' as _i15;
import '../stores/orders_store.dart' as _i16;
import '../stores/products_store.dart'
    as _i17; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.DbConnection>(() => _i3.DbConnection());
  gh.lazySingleton<_i4.HomeController>(() => _i4.HomeController());
  gh.lazySingleton<_i5.IBluetoothPrinter>(() => _i6.ThermalBluetoothPrinter());
  gh.lazySingleton<_i7.ICategoriesRepository>(
      () => _i8.CategoriesRepository(get<_i3.DbConnection>()));
  gh.lazySingleton<_i9.IOrdersRepository>(
      () => _i10.OrdersRepository(get<_i3.DbConnection>()));
  gh.lazySingleton<_i11.IPrinterService>(
      () => _i12.PrinterService(get<_i5.IBluetoothPrinter>()));
  gh.lazySingleton<_i13.IProductRepository>(
      () => _i14.ProductRepository(get<_i3.DbConnection>()));
  gh.factory<_i15.OrderProductsStore>(() => _i15.OrderProductsStore(
      get<_i13.IProductRepository>(), get<_i9.IOrdersRepository>()));
  gh.lazySingleton<_i16.OrdersStore>(
      () => _i16.OrdersStore(get<_i9.IOrdersRepository>()));
  gh.lazySingleton<_i17.ProductsStore>(
      () => _i17.ProductsStore(get<_i13.IProductRepository>()));
  gh.lazySingleton<_i18.CategoriesStore>(
      () => _i18.CategoriesStore(get<_i7.ICategoriesRepository>()));
  gh.factory<_i19.ProductManagementController>(() =>
      _i19.ProductManagementController(
          get<_i18.CategoriesStore>(), get<_i17.ProductsStore>()));
  gh.lazySingleton<_i20.ProductsController>(() => _i20.ProductsController(
      get<_i17.ProductsStore>(), get<_i18.CategoriesStore>()));
  gh.lazySingleton<_i21.SplashController>(
      () => _i21.SplashController(
          get<_i17.ProductsStore>(),
          get<_i13.IProductRepository>(),
          get<_i18.CategoriesStore>(),
          get<_i7.ICategoriesRepository>()),
      dispose: (i) => i.dispose());
  gh.lazySingleton<_i22.CategoriesController>(
      () => _i22.CategoriesController(get<_i18.CategoriesStore>()));
  return get;
}
