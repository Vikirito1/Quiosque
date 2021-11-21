// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/orders/i_orders_repository.dart' as _i4;
import '../data/orders/orders_repository.dart' as _i5;
import '../data/products/i_product_repository.dart' as _i6;
import '../data/products/product_repository.dart' as _i7;
import '../database/db_connection.dart'
    as _i3; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.DbConnection>(() => _i3.DbConnection());
  gh.lazySingleton<_i4.IOrdersRepository>(
      () => _i5.OrdersRepository(get<_i3.DbConnection>()));
  gh.lazySingleton<_i6.IProductRepository>(
      () => _i7.ProductRepository(get<_i3.DbConnection>()));
  return get;
}
