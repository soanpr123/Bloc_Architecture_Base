import 'package:flutter/material.dart';

import 'package:resources/resources.dart';

import '../app.dart';

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget({
    required this.refreshCallBack,
    required this.image,
    this.isConnection = false,
    this.isNodata = false,
    this.isStore = false,
    super.key,
  });
  final Function refreshCallBack;
  final bool isConnection;
  final bool isNodata;
  final Widget image;
  final bool isStore;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom + Dimens.d60.responsive(),
      ),
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
          isStore
              ? Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Text(
                    S.current.no_data_store,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colorTextMedium,
                      fontSize: Dimens.d14.responsive(),
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
                )
              : Container(
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
          TextButton(
            onPressed: () {
              refreshCallBack();
            },
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(colorDisabled),
            ),
            child: Text(
              S.current.reload,
              style: typoInterNomal14.copyWith(color: colorBrandPrimary, fontWeight: FontWeight.w600, height: 1.5),
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
