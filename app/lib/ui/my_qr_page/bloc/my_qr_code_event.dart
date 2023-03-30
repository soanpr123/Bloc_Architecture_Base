import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_event.dart';

part 'my_qr_code_event.freezed.dart';

abstract class MyQrCodeEvent extends BaseBlocEvent {
  const MyQrCodeEvent();
}

@freezed
class MyQrPageInitiated extends MyQrCodeEvent with _$MyQrPageInitiated {
  const factory MyQrPageInitiated() = _MyQrPageInitiated;
}

@freezed
class SaveMyQr extends MyQrCodeEvent with _$SaveMyQr {
  const factory SaveMyQr() = _SaveMyQr;
}
