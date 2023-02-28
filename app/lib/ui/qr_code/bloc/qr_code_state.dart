import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';

import '../../../base/bloc/base_state.dart';

part 'qr_code_state.freezed.dart';

@freezed
class QrCodeState extends BaseBlocState with _$QrCodeState {
  const factory QrCodeState({
    @Default(CameraPermission.permisionApeect) CameraPermission cameraPermission,
  }) = _QrCodeState;
}
