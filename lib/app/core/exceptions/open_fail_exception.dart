import 'package:quiosque/app/core/exceptions/sqflite_exception.dart';

class OpenFailException extends SqfliteException {
  OpenFailException({String? message = 'Falha ao abrir banco de dados!s'})
      : super(message);
}
