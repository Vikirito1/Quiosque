import 'package:intl/intl.dart';

class Formatters {
  static DateFormat dateFormatter() {
    return DateFormat('dd/MM/yyy, HH:mm');
  }

  static NumberFormat moneyFormatter() {
    return NumberFormat.simpleCurrency(decimalDigits: 2, name: 'BRL');
  }

  static NumberFormat moneyFormatterWithoutSymbol() {
    return NumberFormat.currency(symbol: '', decimalDigits: 2);
  }
}
