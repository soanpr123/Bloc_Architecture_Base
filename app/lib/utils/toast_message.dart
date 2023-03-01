import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../app.dart';

class ToastMes {
  ToastMes._({
    required this.fToast,
  });
  static late ToastMes current;
  final FToast fToast;

  static ToastMes of(BuildContext context) {
    final fToast = FToast();
    fToast.init(context);

    final screen = ToastMes._(
      fToast: fToast,
    );

    current = screen;

    return current;
  }
}

void errorToast({String msg = ''}) {
  final toast = Container(
    // width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(0),
      color: colorSupportDanger,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            ToastMes.current.fToast.removeCustomToast();
          },
          child: const Icon(
            Icons.close,
            size: 20,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          width: 12.0,
        ),
        Flexible(
          child: Text(
            msg,
            style: typoInterNomal14.copyWith(fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
      ],
    ),
  );

  ToastMes.current.fToast.showToast(
    child: toast,
    toastDuration: const Duration(seconds: 2),
    positionedToastBuilder: (context, child) {
      return Positioned(
        child: child,
        top: 0.0,
        // left: 16.0,
        right: 0,
        left: 0,
      );
    },
  );
}

void successToast(String msg) {
  final toast = Container(
    // width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(0),
      color: colorBrandPrimary,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            ToastMes.current.fToast.removeCustomToast();
          },
          child: const Icon(
            Icons.close,
            size: 20,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          width: 12.0,
        ),
        Flexible(
          child: Text(
            msg,
            style: typoInterNomal14.copyWith(fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
      ],
    ),
  );

  ToastMes.current.fToast.showToast(
    child: toast,
    toastDuration: const Duration(seconds: 2),
    positionedToastBuilder: (context, child) {
      return Positioned(
        child: child,
        top: 0.0,
        // left: 16.0,
        right: 0,
        left: 0,
      );
    },
  );
}
