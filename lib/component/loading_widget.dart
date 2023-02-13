import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:lottie/lottie.dart';
import 'package:project/core/style/colors.dart';
import 'package:project/core/style/resource.dart';

class LoadingWidget extends StatelessWidget {
  final bool isImage;

  const LoadingWidget({super.key, this.isImage = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    if (isImage) {
      return SpinKitDoubleBounce(
        color: colorBrandPrimary,
      );
    } else {
      return Center(
          child: Lottie.asset(R.ASSETS_JSON_LOADING_JSON,
              width: 100, height: 100, frameRate: FrameRate.max, repeat: true));
    }
  }
}
