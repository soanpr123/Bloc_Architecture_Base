import 'dart:math';

import 'package:intl/intl.dart';

bool checkFormat(String regex, String checkedString) {
  return RegExp(regex).hasMatch(checkedString);
}

String formatNumber(int number) {
  if (number < 1000) return '$number';

  int exponent = (log(number) / log(1000)).floor();
  String suffix = 'kMBTPE'[exponent - 1];
  double n = number / pow(1000, exponent);

  return '${n.toStringAsFixed(1)}$suffix';
}

String fullStringTime(String? stringTime) {
  final date = DateTime.tryParse(stringTime ?? '');
  return date != null ? DateFormat('dd/MM/yyyy HH:mm').format(date.toLocal()) : '';
}

bool isPasswordValid(String password) {
  RegExp pattern = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])[a-zA-Z0-9!@#\$%\^&\*]{8,32}$");
  return pattern.hasMatch(password);
}

bool checkTime() {
  final currentTime = DateTime.now();
  final targetTime = DateTime(currentTime.year, currentTime.month, currentTime.day, 10, 30);

  if (currentTime.isAfter(targetTime)) {
    return true;
  } else {
    return false;
  }
}
