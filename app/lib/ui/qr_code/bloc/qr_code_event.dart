import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../base/bloc/base_event.dart';

part 'qr_code_event.freezed.dart';

abstract class QrCodeEvent extends BaseBlocEvent {
  const QrCodeEvent();
}

@freezed
class QrcodePageInitiated extends QrCodeEvent with _$QrcodePageInitiated {
  const factory QrcodePageInitiated({required QRViewController controller}) = _QrcodePageInitiated;
}
