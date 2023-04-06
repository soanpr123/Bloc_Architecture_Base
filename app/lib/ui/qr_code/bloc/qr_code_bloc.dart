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
  QrCodeBloc(this._qrcodeScanUseCase) : super(const QrCodeState()) {
    on<QrcodePageInitiated>(
      _onQrcodePageInitiated,
      transformer: log(),
    );
  }
  final QrcodeScanUseCase _qrcodeScanUseCase;
  FutureOr<void> _onQrcodePageInitiated(QrcodePageInitiated event, Emitter<QrCodeState> emit) async {
    // ignore: unrelated_type_equality_checks

    event.controller.scannedDataStream.listen((scanData) {
      // AppRouter().push(PaymentAmaiRoute());
      if (scanData.code != null) {
        if (Platform.isAndroid) {
          event.controller.pauseCamera();
        } else if (Platform.isIOS) {
          event.controller.pauseCamera();
        }
        // event.controller.dispose();
        checkType(token: scanData.code ?? '', event: event);
      }
    });

    // await _getTotal(emit: emit);
  }

  Future<void> checkType({required String token, required QrcodePageInitiated event}) async {
    return runBlocCatching(
      doOnSubscribe: () async {},
      action: () async {
        final output = await _qrcodeScanUseCase.execute(QrcodeScanInput(token: token));
        if (output.type == 1) {
          await navigator.push(AppRouteInfo.paymentAmai(output.data.amountAmais));
          await event.controller.resumeCamera();
        } else if (output.type == 2) {
          await navigator.push(AppRouteInfo.sendAmai(output.data.receiveUserId ?? -1));
          await event.controller.resumeCamera();
        } else {
          errorToast(msg: 'Mã Qr không hợp lệ');
          await navigator.pop();
        }
      },
    );
  }
}
