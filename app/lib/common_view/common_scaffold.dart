import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import '../app.dart';

class CommonScaffold extends StatelessWidget {
  const CommonScaffold({
    required this.body,
    this.appBar,
    this.floatingActionButton,
    this.drawer,
    this.backgroundColor,
    this.hideKeyboardWhenTouchOutside = false,
    Key? key,
  }) : super(key: key);

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final bool hideKeyboardWhenTouchOutside;

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold(
      backgroundColor: backgroundColor,
      body: Shimmer(child: body),
      appBar: appBar,
      drawer: drawer,
      floatingActionButton: floatingActionButton,
      resizeToAvoidBottomInset: true, // this i
    );

    return hideKeyboardWhenTouchOutside
        ? GestureDetector(
            onTap: () => ViewUtils.hideKeyboard(context),
            child: scaffold,
          )
        : scaffold;
  }
}
