import 'package:flutter/material.dart';
import 'package:project/core/style/colors.dart';
import 'package:project/core/style/text_style.dart';

final styleTextField = typoInterNomal14;
final decorTextField = InputDecoration(
  enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  contentPadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
  hintStyle: typoInterNomal14.copyWith(color: colorTextBland),
  counterText: '',
  fillColor: Colors.white,
  filled: true,
);
