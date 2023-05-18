import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

import '../../app.dart';

class DialogConfirm extends StatelessWidget {
  const DialogConfirm({
    required this.title,
    required this.message,
    required this.onPressed, this.buttonState,
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
