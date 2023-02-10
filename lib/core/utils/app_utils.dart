import 'dart:math';

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
