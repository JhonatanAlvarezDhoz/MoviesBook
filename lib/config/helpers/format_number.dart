import 'package:intl/intl.dart';

class FormatNumber {
  static String number(double number, [int decimals = 0]) {
    final formatNumber = NumberFormat.compactCurrency(
            decimalDigits: decimals, symbol: '', locale: 'en')
        .format(number);

    return formatNumber;
  }
}
