import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:project/core/routers/router.dart';
import 'package:project/core/style/transaction.dart';
import 'package:project/core/utils/constants.dart';
import 'package:project/core/utils/toast_message.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

part 'qr_code_page_state.dart';

class QrCodePageCubit extends Cubit<QrCodePageState> {
  QrCodePageCubit() : super(QrCodePageState());

  void onQRViewCreated(QRViewController controller, BuildContext context) {
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code == codePayment) {
        AppRouter().push(PaymentAmaiRoute());
        if (Platform.isAndroid) {
          controller.pauseCamera();
        } else if (Platform.isIOS) {
          controller.resumeCamera();
        }
        controller.dispose();
      } else {
        errorToast(msg: translation(context).err_qr);
      }
      emit(state.addState(result: scanData.code ?? ""));
    });
  }
}
