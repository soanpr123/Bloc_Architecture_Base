import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

import '../../app.dart';
import '../../app/bloc/app_bloc.dart';
import '../../shared_view/app_netword_image.dart';
import 'bloc/report_page_bloc.dart';

class SucessReportDialog extends StatelessWidget {
  const SucessReportDialog({required this.reportPageBloc, required this.appNavigator, Key? key}) : super(key: key);
  final AppBloc reportPageBloc;
  final AppNavigator appNavigator;
  @override
  Widget build(BuildContext context) {
    return CustomAlert(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                child: AppNetworkImageAvatar(
                    source: reportPageBloc.state.users.incognito?.avatar ?? '', fit: BoxFit.cover),
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
                  fontWeight: FontWeight.w400, height: 1.5, color: colorTextMedium, fontSize: Dimens.d14.responsive()),
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
    );
  }
}
