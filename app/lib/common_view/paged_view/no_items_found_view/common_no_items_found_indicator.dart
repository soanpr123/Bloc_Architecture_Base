import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:resources/resources.dart';

import '../../../app.dart';

class CommonNoItemsFoundIndicator extends StatelessWidget {
  const CommonNoItemsFoundIndicator({this.isStore = false, Key? key}) : super(key: key);
  final bool isStore;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        isStore
            ? Assets.svg.storeNodata.svg(width: 150, height: 150)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(Assets.json.nodata.path, width: 150, height: 150, frameRate: FrameRate.max, repeat: true),
                ],
              ),
        const SizedBox(
          height: 8,
        ),
        isStore
            ? Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text(
                  S.current.no_data_store,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colorGray600,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            : Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text(
                  S.current.no_data,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colorGray600,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
      ],
    );
  }
}
