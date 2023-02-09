import 'package:flutter/material.dart';
import 'package:project/core/style/colors.dart';
// import 'package:lms_telemor/app/theme/colors.dart';

enum AppElevatedButtonState { active, inactive, loading, reverse }

class AppElevatedButton extends StatelessWidget {
  final String? buttonTitle;
  final Color? mainColor;
  final VoidCallback? onPressed;
  final AppElevatedButtonState state;
  final TextStyle? style;
  const AppElevatedButton(
      {super.key,
      this.buttonTitle,
      this.onPressed,
      this.mainColor,
      this.style,
      this.state = AppElevatedButtonState.active});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: state == AppElevatedButtonState.active ? onPressed : null,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) return mainColor ?? colorBrandPrimary;
            if (states.contains(MaterialState.disabled)) return Colors.grey;
            return mainColor ?? colorBrandPrimary;
          },
        ),
        shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
          (Set<MaterialState> states) {
            return RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            );
          },
        ),
      ),
      child: SizedBox(
        height: 48,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: state == AppElevatedButtonState.loading ? 16.0 : 0.0,
              width: state == AppElevatedButtonState.loading ? 16.0 : 0.0,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).disabledColor,
                ),
                strokeWidth: 2,
              ),
            ),
            SizedBox(
              width: state == AppElevatedButtonState.loading ? 8.0 : 0.0,
            ),
            Text(
              buttonTitle ?? '',
              style: style ??
                  TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: state == AppElevatedButtonState.active ? Colors.white : Colors.black38,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
