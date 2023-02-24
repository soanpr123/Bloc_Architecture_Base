import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

import '../../app.dart';

class DialogConfirm extends StatelessWidget {
  const DialogConfirm({
    required this.title,
    required this.message,
    this.buttonState,
    required this.onPressed,
    Key? key,
  }) : super(key: key);
  final String title;
  final Widget message;
  final AppElevatedButtonState? buttonState;
  final Function? onPressed;
  @override
  Widget build(BuildContext context) {
    return CustomAlert(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(children: [
          Row(
            children: [
              Text(
                S.current.confirm_amai,
                style: typoInterNomal18,
              ),
            ],
          ),
          SizedBox(
            height: Dimens.d24.responsive(),
          ),
          message,
          SizedBox(
            height: Dimens.d16.responsive(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: Dimens.d60.responsive(),
                child: AppElevatedButton(
                  mainColor: colorBrandSecondary,
                  onPressed: () {
                    Navigator.pop(context);
                    // gotoFogot(false);
                  },
                  buttonTitle: S.current.cancel,
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              SizedBox(
                width: Dimens.d100.responsive(),
                child: AppElevatedButton(
                  state: buttonState ?? AppElevatedButtonState.active,
                  onPressed: () {
                    onPressed!();
                    Navigator.pop(context);
                  },
                  buttonTitle: S.current.confirm,
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
