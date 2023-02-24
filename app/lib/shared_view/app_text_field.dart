import 'package:flutter/material.dart';

import '../app.dart';
import 'app_text_form_field.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.title,
    this.hintText = '',
    this.suffixIcon,
    this.controller,
    this.onChanged,
    this.onTap,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    Key? key,
  }) : super(key: key);

  final String title;
  final String hintText;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final VoidCallback? onTap;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: typoInterNomal16.copyWith(color: colorTextMedium),
          ),
        ),
        SizedBox(height: Dimens.d8.responsive()),
        AppTextFormField(
          borderRadius: Dimens.d5.responsive(),
          onTap: onTap,
          onChanged: onChanged,
          controller: controller,
          obscureText: obscureText,
          hintText: hintText,
          keyboardType: keyboardType,
          suffixIcon: suffixIcon,
        ),
      ],
    );
  }
}
