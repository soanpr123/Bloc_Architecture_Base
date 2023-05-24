import 'package:flutter/material.dart';

import '../../app.dart';

final styleTextField = typoInterNomal14;
final decorTextField = InputDecoration(
  enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
  contentPadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4),
  hintStyle: typoInterNomal14.copyWith(color: colorTextBland),
  counterText: '',
  fillColor: Colors.white,
  filled: true,
);
final boxShadow = [
  BoxShadow(
    color: Colors.black.withOpacity(0.2),
    spreadRadius: 0,
    blurRadius: 4,
    offset: const Offset(0, 1),
  ),
];
