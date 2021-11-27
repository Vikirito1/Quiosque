import 'package:quiosque/app/core/exceptions/sqflite_exceptions.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteExceptionHandler {
  static SqfliteException handleException(DatabaseException e) {
    if (e.isDuplicateColumnError()) {
      throw DuplicateColumnException();
    } else if (e.isDatabaseClosedError()) {
      throw ClosedDatabaseException();
    } else if (e.isNotNullConstraintError()) {
      throw NotNullException();
    } else if (e.isNoSuchTableError()) {
      throw TableNotFoundException();
    } else if (e.isOpenFailedError()) {
      throw OpenFailException();
    } else if (e.isUniqueConstraintError()) {
      throw UniqueFieldException();
    } else {
      throw UnspecifiedException(e.toString());
    }
  }
}
