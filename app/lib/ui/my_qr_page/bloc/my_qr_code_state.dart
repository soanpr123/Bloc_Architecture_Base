import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_state.dart';

part 'my_qr_code_state.freezed.dart';

@freezed
class MyQrCodeState extends BaseBlocState with _$MyQrCodeState {
  const factory MyQrCodeState() = _MyQrCodeState;
}
