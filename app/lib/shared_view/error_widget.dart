import 'package:flutter/material.dart';

import 'package:resources/resources.dart';

import '../app.dart';

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget({
    required this.refreshCallBack,
    required this.image,
    this.isConnection = false,
    this.isNodata = false,
    super.key,
  });
  final Function refreshCallBack;
  final bool isConnection;
  final bool isNodata;
  final Widget image;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          isConnection
              ? Assets.png.noInternet.image(width: Dimens.d200.responsive(), height: Dimens.d198.responsive())
              : image,
          SizedBox(
            height: Dimens.d20.responsive(),
          ),
          isConnection
              ? Column(
                  children: [
                    Text(
                      S.current.internetOpp,
                      style: typoInterNomal14.copyWith(
                        color: colorBrandPrimary,
                        fontSize: Dimens.d24.responsive(),
                        fontWeight: FontWeight.w700,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(
                      height: Dimens.d12.responsive(),
                    ),
                  ],
                )
              : Container(),
          Container(
            margin: const EdgeInsets.only(bottom: 15.0),
            child: Text(
              getErrorText(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colorTextMedium,
                fontSize: Dimens.d14.responsive(),
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
          ),
          Container(
            child: AppElevatedButton(
              onPressed: () {
                refreshCallBack();
              },
              buttonTitle: S.current.reload,
            ),
          ),
        ],
      ),
    );
  }

  String getErrorText() {
    if (isConnection) {
      return S.current.InternetException;
    } else if (isNodata) {
      return S.current.no_data;
    } else {
      return S.current.error_other;
    }
  }
}
