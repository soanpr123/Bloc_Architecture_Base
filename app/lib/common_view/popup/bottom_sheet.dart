import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomSheetCommon extends StatelessWidget {
  const BottomSheetCommon({required this.child, Key? key}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: child);
  }
}
