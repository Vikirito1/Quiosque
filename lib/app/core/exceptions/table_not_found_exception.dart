import 'package:quiosque/app/core/exceptions/sqflite_exception.dart';

class TableNotFoundException extends SqfliteException {
  TableNotFoundException({
    String? message =
        'Tabela não encontrada. Verifique a query e tente novamente',
  }) : super(message);
}
