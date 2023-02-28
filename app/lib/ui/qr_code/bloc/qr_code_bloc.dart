import 'dart:async';
import 'dart:io';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

import '../../../app.dart';

import '../../../utils/toast_message.dart';

@Injectable()
class QrCodeBloc extends BaseBloc<QrCodeEvent, QrCodeState> {
  QrCodeBloc() : super(const QrCodeState()) {
    on<QrcodePageInitiated>(
      _onQrcodePageInitiated,
      transformer: log(),
    );
  }

  FutureOr<void> _onQrcodePageInitiated(QrcodePageInitiated event, Emitter<QrCodeState> emit) async {
    final status = await PermissionConstants.checkPermissionCamera();
    // ignore: unrelated_type_equality_checks
    if (status == CameraPermission.permisionApeect) {
      event.controller.scannedDataStream.listen((scanData) {
        if (scanData.code == SymbolConstants.codePayment) {
          // AppRouter().push(PaymentAmaiRoute());
          navigator.push(const AppRouteInfo.paymentAmai());
          if (Platform.isAndroid) {
            event.controller.pauseCamera();
          } else if (Platform.isIOS) {
            event.controller.resumeCamera();
          }
          event.controller.dispose();
        } else {
          navigator.pop();
          errorToast(msg: S.current.err_qr);
        }
      });
    } else {}

    // await _getTotal(emit: emit);
  }
}
