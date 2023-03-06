import 'package:flutter/material.dart';

// import 'package:lms_telemor/app/theme/colors.dart';
import '../../app.dart';

enum AppElevatedButtonState { active, inactive, loading, reverse }

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    super.key,
    this.buttonTitle,
    this.onPressed,
    this.mainColor,
    this.style,
    this.state = AppElevatedButtonState.active,
  });

  final String? buttonTitle;
  final Color? mainColor;
  final VoidCallback? onPressed;
  final AppElevatedButtonState state;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: state == AppElevatedButtonState.active ? onPressed : null,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return mainColor ?? colorBrandPrimary;
            }
            if (states.contains(MaterialState.disabled)) {
              return colorDisabled;
            }

            return mainColor ?? colorBrandPrimary;
          },
        ),
        shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
          (Set<MaterialState> states) {
            return RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            );
          },
        ),
        elevation: MaterialStateProperty.all(0.0),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
      ),
      child: SizedBox(
        height: Dimens.d40.responsive(),
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
                  typoInterNomal14.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
