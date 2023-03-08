import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:resources/resources.dart';

import '../../app.dart';
import '../../resource/generated/assets.gen.dart';

class FeatureDeveloperPage extends StatelessWidget {
  const FeatureDeveloperPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      body: Padding(
        padding: EdgeInsets.all(Dimens.d16.responsive()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Assets.png.icFeature.image()),
            SizedBox(
              height: Dimens.d24.responsive(),
            ),
            Text(
              S.current.function_update,
              style: typoInterNomal18.copyWith(
                fontSize: Dimens.d24.responsive(),
                height: 1.5,
                color: colorBrandPrimary,
              ),
            ),
            SizedBox(
              height: Dimens.d12.responsive(),
            ),
            Text(
              S.current.function_update_detail,
              textAlign: TextAlign.center,
              style: typoInterNomal14.copyWith(
                height: 1.5,
                color: colorTextMedium,
              ),
            ),
            TextButton(
              onPressed: () {
                GetIt.instance.get<AppNavigator>().pop();
              },
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(colorDisabled),
              ),
              child: Text(
                S.current.back_to_home,
                style: typoInterNomal14.copyWith(color: colorBrandPrimary, fontWeight: FontWeight.w600, height: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
