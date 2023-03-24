import 'package:app/style/app_text_styles.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../../../app.dart';

class DialogDonate extends StatelessWidget {
  const DialogDonate({Key? key, required this.popUpDonateEntry}) : super(key: key);
  final PopUpDonateEntry popUpDonateEntry;
  @override
  Widget build(BuildContext context) {
    return CustomAlert(
      child: SafeArea(
        minimum: EdgeInsets.all(16),
        child: Column(
          children: [
            Assets.png.gifPopup.image(),
            SizedBox(
              height: Dimens.d24.responsive(),
            ),
            RichText(
              text: TextSpan(
                text: 'Bạn được tặng ',
                style: typoInterNomal16.copyWith(
                  color: colorTextMedium,
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  height: 1.5,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '${popUpDonateEntry.amountAmais} Amai',
                    style: typoInterNomal16.copyWith(
                      color: colorBrandPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Dimens.d24.responsive(),
            ),
            RichText(
              text: TextSpan(
                text: 'Bạn được ',
                style: typoInterNomal14.copyWith(
                  color: colorTextMedium,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.5,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: popUpDonateEntry.donor,
                    style: typoInterNomal14.copyWith(
                      color: colorBrandPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  TextSpan(
                    text: ' tặng Amai với lời nhắn:“${popUpDonateEntry.note}"',
                    style: typoInterNomal14.copyWith(
                      color: colorTextMedium,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Dimens.d24.responsive(),
            ),
            AppElevatedButton(
              buttonTitle: 'Nhận',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
