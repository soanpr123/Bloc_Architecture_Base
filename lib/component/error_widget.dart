import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:lottie/lottie.dart';
import 'package:project/component/app_elevated_button.dart';
import 'package:project/core/style/colors.dart';
import 'package:project/core/style/resource.dart';
import 'package:project/core/style/transaction.dart';

class MyErrorWidget extends StatelessWidget {
  final Function refreshCallBack;
  final bool isConnection;
  final bool isNodata;
  final bool isStoreNodata;
  const MyErrorWidget(
      {super.key,
      required this.refreshCallBack,
      this.isConnection = false,
      this.isNodata = false,
      this.isStoreNodata = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          isNodata
              ? Lottie.asset(R.ASSETS_JSON_NODATA_JSON, width: 150, height: 150, frameRate: FrameRate.max, repeat: true)
              : isStoreNodata
                  ? SvgPicture.asset(
                      R.ASSETS_SVG_STORE_NODATA_SVG,
                      width: 150,
                      height: 150,
                    )
                  : Lottie.asset(
                      R.ASSETS_JSON_NO_CONNECT_JSON,
                      width: 150,
                      height: 150,
                      frameRate: FrameRate.max,
                      repeat: true,
                    ),
          const SizedBox(
            height: 8,
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 15.0),
            child: Text(
              getErrorText(context),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colorGray600,
                fontSize: 17.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          AppElevatedButton(
            mainColor: colorGray600,
            onPressed: () {
              refreshCallBack();
            },
            buttonTitle: translation(context).reload,
          ),
        ],
      ),
    );
  }

  getErrorText(BuildContext context) {
    if (isConnection) {
      return translation(context).internet_error;
    } else if (isNodata) {
      return translation(context).no_data;
    } else if (isStoreNodata) {
      return translation(context).no_data_store;
    } else {
      return translation(context).error_other;
    }
  }
}
