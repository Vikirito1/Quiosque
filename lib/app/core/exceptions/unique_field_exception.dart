import 'package:quiosque/app/core/exceptions/sqflite_exception.dart';

class UniqueFieldException extends SqfliteException {
  UniqueFieldException({String? message = 'Campo único violado'})
      : super(message);
}
