import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

import '../../app.dart';

import '../../shared_view/app_netword_image.dart';

class SucessReportDialog extends StatelessWidget {
  const SucessReportDialog(
      {required this.reportPageBloc, required this.appNavigator, required this.reportPage, Key? key})
      : super(key: key);
  final AppBloc reportPageBloc;
  final AppNavigator appNavigator;
  final ReportPageBloc reportPage;
  @override
  Widget build(BuildContext context) {
    return CustomAlert(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: GestureDetector(
              onTap: () {
                reportPage.add(const ClosePopUp(closePopUp: true));
                appNavigator.pop();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.close,
                    color: colorGray400,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Column(
              children: [
                SizedBox(
                  // color: colorRed200,
                  height: Dimens.d100.responsive(),
                  width: Dimens.d100.responsive(),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: Dimens.d80.responsive(),
                          width: Dimens.d80.responsive(),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(50)),
                            child: AppNetworkImageAvatar(
                              source: reportPageBloc.state.users.incognito?.avatar ?? '',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: Dimens.d100.responsive(),
                          width: Dimens.d100.responsive(),
                          child: Assets.png.boxAvatar.image(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Dimens.d24.responsive(),
                ),
                Assets.svg.thanksyou.svg(),
                SizedBox(
                  height: Dimens.d16.responsive(),
                ),
                Text(
                  S.current.report_content_success,
                  textAlign: TextAlign.center,
                  style: typoInterNomal14.copyWith(
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    color: colorTextMedium,
                    fontSize: Dimens.d14.responsive(),
                  ),
                ),
                SizedBox(
                  height: Dimens.d24.responsive(),
                ),
                AppElevatedButton(
                  onPressed: () {
                    appNavigator.popUntilRoot(useRootNavigator: true);
                    appNavigator.navigateToBottomTab(0);
                  },
                  buttonTitle: S.current.back_to_home,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
