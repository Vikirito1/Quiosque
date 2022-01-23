import 'package:injectable/injectable.dart';
import 'package:quiosque/app/core/data/dtos/category_dto.dart';
import 'package:quiosque/app/core/database/db_connection.dart';
import 'package:quiosque/app/core/models/category_model.dart';
import 'package:quiosque/app/core/utils/sqflite_exception_handler.dart';
import 'package:sqflite/sqlite_api.dart';

import './i_categories_repository.dart';

@LazySingleton(as: ICategoriesRepository)
class CategoriesRepository implements ICategoriesRepository {
  CategoriesRepository(this._connection);

  final DbConnection _connection;

  @override
  Future<int> createCategory(CategoryDTO categoryDTO) async {
    final Database connection = await _connection.openConnection();
    try {
      final int categoryId = await connection.rawInsert(
        'INSERT INTO categories(category) VALUES (?)',
        [categoryDTO.category],
      );
      return categoryId;
    } on DatabaseException catch (e) {
      throw SqfliteExceptionHandler.handleException(e);
    } finally {
      await connection.close();
    }
  }

  @override
  Future<int> deleteCategory(int categoryId) async {
    final Database connection = await _connection.openConnection();
    try {
      final int deletedLinesCount = await connection.delete(
        'categories',
        where: 'id = ?',
        whereArgs: [categoryId],
      );
      return deletedLinesCount;
    } on DatabaseException catch (e) {
      throw SqfliteExceptionHandler.handleException(e);
    } finally {
      await connection.close();
    }
  }

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    final Database connection = await _connection.openConnection();
    try {
      final results =
          await connection.query('categories', columns: ['id', 'category']);
      return results
          .map((categoryMap) => CategoryModel.fromJson(categoryMap))
          .toList();
    } on DatabaseException catch (e) {
      throw SqfliteExceptionHandler.handleException(e);
    } finally {
      await connection.close();
    }
  }

  @override
  Future<int> updateCategory(CategoryDTO categoryDTO) async {
    final Database connection = await _connection.openConnection();
    try {
      final updatedCategoriesCount = await connection.update(
        'categories',
        categoryDTO.toJson(),
      );
      return updatedCategoriesCount;
    } on DatabaseException catch (e) {
      throw SqfliteExceptionHandler.handleException(e);
    } finally {
      await connection.close();
    }
  }

  @override
  Future<List<int>> createMultipleCategories(
      List<CategoryDTO> categoriesList) async {
    final Database connection = await _connection.openConnection();
    try {
      final List<int> addedCategoriesIds =
          await connection.transaction<List<int>>((txn) async {
        final List<int> addedIds = <int>[];
        for (CategoryDTO categoryDTO in categoriesList) {
          final int id = await txn.insert('categories', categoryDTO.toJson());
          addedIds.add(id);
        }
        return addedIds;
      });
      return addedCategoriesIds;
    } on DatabaseException catch (e) {
      throw SqfliteExceptionHandler.handleException(e);
    } finally {
      await connection.close();
    }
  }
}
