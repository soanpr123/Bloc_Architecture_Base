import 'package:flutter/material.dart';

import '../style/app_text_styles.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({super.key, this.buttonTitle, this.onPressed, this.color, this.textStyle});
  final String? buttonTitle;
  final Color? color;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      
      child: Text(
        buttonTitle ?? '',
        style: textStyle ?? typoInterNomal14.copyWith(color: color ?? Colors.white, fontSize: 14),
      ),
    );
  }
}
