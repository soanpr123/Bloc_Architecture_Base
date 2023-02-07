import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project/core/style/colors.dart';

errorToast({String msg = ""}) {
  Fluttertoast.showToast(
      msg: msg == "" ? "Lỗi không xác định" : msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: colorSupportDanger,
      textColor: Colors.white,
      fontSize: 16.0);
}

successToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: colorBrandPrimary,
      textColor: Colors.white,
      fontSize: 16.0);
}
