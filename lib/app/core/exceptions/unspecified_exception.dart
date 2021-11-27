import 'package:quiosque/app/core/exceptions/sqflite_exception.dart';

class UnspecifiedException extends SqfliteException {
  UnspecifiedException(String? message) : super(message);
}
