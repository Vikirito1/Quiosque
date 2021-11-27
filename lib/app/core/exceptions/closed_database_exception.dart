import 'package:quiosque/app/core/exceptions/sqflite_exception.dart';

class ClosedDatabaseException extends SqfliteException {
  ClosedDatabaseException({String? message = 'Banco de dados fechado'})
      : super(message);
}
