import 'package:intl/intl.dart';


class HumanFormats {

  static String bigNumber(double number) {

    final formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
      locale: 'en'
    ).format(number);

    return formattedNumber;
  }

  static String average(double number) {

    final formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: 1,
      symbol: '',
      locale: 'en'
    ).format(number);

    return formattedNumber;
  }
}
