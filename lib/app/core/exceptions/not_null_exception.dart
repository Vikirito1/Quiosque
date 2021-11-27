import 'package:quiosque/app/core/exceptions/sqflite_exception.dart';

class NotNullException extends SqfliteException {
  NotNullException({String? message = 'Campo obrigatório nulo'})
      : super(message);
}
