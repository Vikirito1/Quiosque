import 'package:quiosque/app/core/exceptions/sqflite_exception.dart';

class DuplicateColumnException extends SqfliteException {
  DuplicateColumnException({String? message = 'Coluna duplicada'})
      : super(message);
}
