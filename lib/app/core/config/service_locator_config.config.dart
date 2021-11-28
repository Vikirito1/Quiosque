// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../modules/home/home_controller.dart' as _i4;
import '../../modules/splash/splash_controller.dart' as _i12;
import '../data/orders/i_orders_repository.dart' as _i5;
import '../data/orders/orders_repository.dart' as _i6;
import '../data/products/i_product_repository.dart' as _i7;
import '../data/products/product_repository.dart' as _i8;
import '../database/db_connection.dart' as _i3;
import '../stores/order_products_store.dart' as _i9;
import '../stores/orders_store.dart' as _i10;
import '../stores/products_store.dart'
    as _i11; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.DbConnection>(() => _i3.DbConnection());
  gh.lazySingleton<_i4.HomeController>(() => _i4.HomeController());
  gh.lazySingleton<_i5.IOrdersRepository>(
      () => _i6.OrdersRepository(get<_i3.DbConnection>()));
  gh.lazySingleton<_i7.IProductRepository>(
      () => _i8.ProductRepository(get<_i3.DbConnection>()));
  gh.lazySingleton<_i9.OrderProductsStore>(
      () => _i9.OrderProductsStore(get<_i7.IProductRepository>()));
  gh.lazySingleton<_i10.OrdersStore>(
      () => _i10.OrdersStore(get<_i5.IOrdersRepository>()));
  gh.lazySingleton<_i11.ProductsStore>(
      () => _i11.ProductsStore(get<_i7.IProductRepository>()));
  gh.lazySingleton<_i12.SplashController>(
      () => _i12.SplashController(get<_i11.ProductsStore>()),
      dispose: (i) => i.dispose());
  return get;
}
