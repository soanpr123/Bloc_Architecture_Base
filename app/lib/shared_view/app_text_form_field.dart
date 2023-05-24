import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../app.dart';

class AppTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? errorText;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? autofocus;
  final bool? readOnly;
  final Function()? onEditingComplete;
  final Function(String)? onChanged;
  final Function()? onTap;
  final ValueChanged<String>? onSubmitted;
  final Color? colorBorderFocus;
  final Color? colorBorderEnable;
  final double? borderRadius;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final int? minLines;
  final Color? colorErr;
  final bool? expans;
  final InputCounterWidgetBuilder? counterInput;
  final FocusNode? focusNode;
  // ignore: member-ordering
  const AppTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.inputFormatters,
    this.errorText,
    this.obscureText,
    this.keyboardType,
    this.textInputAction,
    this.maxLength,
    this.minLines,
    this.prefixIcon,
    this.suffixIcon,
    this.autofocus,
    this.readOnly,
    this.onEditingComplete,
    this.onChanged,
    this.onTap,
    this.onSubmitted,
    this.colorBorderFocus,
    this.borderRadius,
    this.colorBorderEnable,
    this.maxLines,
    this.colorErr,
    this.counterInput,
    this.expans = false,
    this.focusNode,
  });

  @override
  _AppTextFormFieldState createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.readOnly ?? false,
      focusNode: widget.focusNode,
      controller: widget.controller,
      style: styleTextField,
      obscureText: widget.obscureText ?? false,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      maxLength: widget.maxLength,
      autofocus: widget.autofocus ?? false,
      autocorrect: false,
      expands: widget.expans ?? false,
      minLines: widget.minLines ?? 1,
      maxLines: widget.maxLines ?? 1,
      onEditingComplete: widget.onEditingComplete,
      onChanged: widget.onChanged,
      inputFormatters: widget.inputFormatters,
      buildCounter: widget.counterInput,
      onFieldSubmitted: (text) {
        widget.onSubmitted ?? (text) {};
      },
      onTap: widget.onTap,
      decoration: decorTextField.copyWith(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.colorBorderFocus ?? colorBrandPrimary),
          borderRadius: BorderRadius.circular(
            widget.borderRadius ?? 0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.colorBorderEnable ?? colorBoder01,
          ),
          borderRadius: BorderRadius.circular(
            widget.borderRadius ?? 0,
          ),
        ),
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        contentPadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
        // isDense: true,
        errorText: widget.errorText,
        errorMaxLines: 1,
        errorStyle: const TextStyle(fontSize: 0.01),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.colorErr ?? colorSupportDanger),
          borderRadius: BorderRadius.circular(
            widget.borderRadius ?? 0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.colorErr ?? colorSupportDanger),
          borderRadius: BorderRadius.circular(
            widget.borderRadius ?? 0,
          ),
        ),
      ),
    );
  }
}
