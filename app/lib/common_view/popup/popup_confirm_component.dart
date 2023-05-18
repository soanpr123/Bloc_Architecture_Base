import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

import '../../app.dart';

class DialogConfirmCommon extends StatelessWidget {
  const DialogConfirmCommon({
    required this.title,
    required this.onPressed, this.message,
    this.buttonState,
    this.tileButton,
    Key? key,
  }) : super(key: key);
  final String title;
  final String? message;
  final String? tileButton;
  final AppElevatedButtonState? buttonState;
  final Function? onPressed;
  @override
  Widget build(BuildContext context) {
    return CustomAlert(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimens.d12.responsive(), vertical: Dimens.d12.responsive()),
        child: Column(children: [
          Row(
            children: [
              Text(
                message ?? 'Thông báo',
                style: typoInterNomal18.copyWith(color: colorTextDark),
              ),
            ],
          ),
          SizedBox(
            height: Dimens.d24.responsive(),
          ),
          Text(
            title,
            style: typoInterNomal14.copyWith(color: colorTextMedium, fontSize: Dimens.d14.responsive()),
          ),
          SizedBox(
            height: Dimens.d24.responsive(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Expanded(flex: 2, child: SizedBox()),
              Expanded(
                flex: 0,
                child: AppElevatedButton(
                  mainColor: colorBrandSecondary,
                  onPressed: () {
                    Navigator.pop(context);
                    // gotoFogot(false);
                  },
                  buttonTitle: S.current.cancel,
                ),
              ),
              SizedBox(
                width: Dimens.d12.responsive(),
              ),
              Expanded(
                flex: 2,
                child: AppElevatedButton(
                  state: buttonState ?? AppElevatedButtonState.active,
                  onPressed: () {
                    onPressed!();
                    Navigator.pop(context);
                  },
                  buttonTitle: tileButton ?? S.current.confirm,
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
