import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MaxWordTextInputFormater extends TextInputFormatter {
  final int maxWords;
  final ValueChanged<int>? currentLength;

  // ignore: member-ordering
  MaxWordTextInputFormater({this.maxWords = 1, this.currentLength});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    int count = 0;
    count = newValue.text.isEmpty ? 0 : newValue.text.trim().length;
    if (count > maxWords) {
      return oldValue;
    }
    currentLength?.call(count);

    return newValue;
  }
}
