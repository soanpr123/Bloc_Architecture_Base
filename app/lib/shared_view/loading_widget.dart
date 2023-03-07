import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

import '../app.dart';
import '../resource/dimens/dimens.dart';
import '../resource/generated/assets.gen.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        Assets.json.loading,
        width: Dimens.d100.responsive(),
        height: Dimens.d100.responsive(),
        frameRate: FrameRate.max,
        repeat: true,
      ),
    );
  }
}
