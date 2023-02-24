
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:resources/resources.dart';

import '../app.dart';

void errorToast({String msg = ''}) {
  Fluttertoast.showToast(
    msg: msg == '' ? S.current.error_other : msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor: colorSupportDanger,
    textColor: Colors.white,
    fontSize: Dimens.d16.responsive(),
  );
}

void successToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor: colorBrandPrimary,
    textColor: Colors.white,
    fontSize: Dimens.d16.responsive(),
  );
}
