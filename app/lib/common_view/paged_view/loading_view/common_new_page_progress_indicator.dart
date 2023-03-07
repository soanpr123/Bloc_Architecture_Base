import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../app.dart';

class CommonNewPageProgressIndicator extends StatelessWidget {
  const CommonNewPageProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(Dimens.d8.responsive()),
        child: Lottie.asset(
          Assets.json.loadmore,
          width: Dimens.d100.responsive(),
          height: Dimens.d100.responsive(),
          frameRate: FrameRate.max,
          repeat: true,
        ),
      ),
    );
  }
}
