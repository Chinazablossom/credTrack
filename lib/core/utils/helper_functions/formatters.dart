import 'package:intl/intl.dart';

class Formatter {

  static String formatPhoneNumber(String number) {
    if (number.length == 11) {
      return "(${number.substring(0, 4)}) ${number.substring(4, 7)} ${number.substring(7)}";
    } else if (number.length == 10) {
      return "(${number.substring(0, 3)}) ${number.substring(3, 6)} ${number
          .substring(6)}";
    }

    return number;
  }

  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat("dd-MM-yyyy").format(date);
  }

  static String formatToUSD(double amount) {
    return NumberFormat.currency(locale: "en_US", symbol: "\$").format(amount);
  }

  static String formatToEuro(double amount) {
    return NumberFormat.currency(locale: "de_DE", symbol: "€").format(amount);
  }

  static String formatToNaira(double amount) {
    return NumberFormat.currency(locale: "en_NG", symbol: "₦").format(amount);
  }

  static String formatToPounds(double amount) {
    return NumberFormat.currency(locale: "en_GB", symbol: "£").format(amount);
  }

}