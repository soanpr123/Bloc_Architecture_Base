import 'dart:math';

import 'package:intl/intl.dart';

import '../../shared.dart';

class NumberFormatUtils {
  NumberFormatUtils._();

  static String formatYen(double price) {
    return NumberFormat.currency(symbol: SymbolConstants.yen, decimalDigits: 0).format(price);
  }

  static String formatNumber(int number) {
    return NumberFormat(NumberFormatConstants.defaultFormat).format(number);
  }

  static String formatNumbers(int number) {
    if (number < 1000) {
      return '$number';
    }

    final exponent = (log(number) / log(1000)).floor();
    final suffix = 'kMBTPE'[exponent - 1];
    // ignore: prefer-correct-identifier-length
    final n = number / pow(1000, exponent);

    return '${n.toStringAsFixed(1)}$suffix';
  }
}
