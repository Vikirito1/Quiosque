import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@LazySingleton()
class DbConnection {
  static const String _productsTableQuery = '''
    CREATE TABLE IF NOT EXISTS products (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      product TEXT NOT NULL,
      price REAL NOT NULL,
      categories_id INTEGER NOT NULL,
      FOREIGN KEY (categories_id) REFERENCES categories(id)
      ON UPDATE CASCADE
      ON DELETE CASCADE
    );
  ''';

  static const String _ordersTableQuery = '''
    CREATE TABLE IF NOT EXISTS orders (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      table_number INTEGER NOT NULL,
      is_opened INTEGER DEFAULT 0
    );
  ''';

  static const String _categoriesTableQuery = '''
    CREATE TABLE IF NOT EXISTS categories(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      category TEXT NOT NULL
    );
  ''';

  static const String _ordersHasProductsTableQuery = '''
    CREATE TABLE IF NOT EXISTS orders_has_products (
      orders_id INTEGER NOT NULL,
      products_id INTEGER NOT NULL,
      quantity INTEGER NOT NULL,
      FOREIGN KEY (orders_id) REFERENCES orders(id)
      ON UPDATE CASCADE
      ON DELETE CASCADE
      FOREIGN KEY (products_id) REFERENCES products(id)
      ON UPDATE CASCADE
      ON DELETE CASCADE
    );
  ''';

  Future<Database> openConnection() async {
    final String databasesPath = await getDatabasesPath();
    final String path = '$databasesPath/quiosque.db';
    final Database database = await openDatabase(
      path,
      version: 1,
      singleInstance: true,
      onCreate: (Database db, int version) async {
        await db.execute(_categoriesTableQuery);
        await db.execute(_productsTableQuery);
        await db.execute(_ordersTableQuery);
        await db.execute(_ordersHasProductsTableQuery);
      },
    );
    return database;
  }
}
