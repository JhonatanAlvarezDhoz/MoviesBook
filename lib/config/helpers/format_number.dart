import 'package:intl/intl.dart';

class FormatNumber {
  static String number(double number) {
    final formatNumber =
        NumberFormat.compactCurrency(decimalDigits: 0, symbol: '', locale: 'en')
            .format(number);

    return formatNumber;
  }
}
