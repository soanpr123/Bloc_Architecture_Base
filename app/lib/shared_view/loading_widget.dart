import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

import '../app.dart';

import '../resource/generated/assets.gen.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.isLoadingNew = true});
  final bool isLoadingNew;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: isLoadingNew
          ? Lottie.asset(
              Assets.json.loading.path,
              frameRate: FrameRate.max,
              repeat: true,
            )
          : Lottie.asset(
              Assets.json.loadmore.path,
              frameRate: FrameRate.max,
              repeat: true,
              width: 100,
              height: 100,
            ),
    );
  }
}
