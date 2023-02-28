
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_state.dart';

part 'change_pass_state.freezed.dart';

@freezed
class ChangePassState extends BaseBlocState with _$ChangePassState {
  const factory ChangePassState({
    @Default(true) bool showCurrentPass,
    @Default(true) bool showNewPass,
    @Default(true) bool showConfirmPass,
    @Default('') String currPass,
    @Default('') String newPass,
    @Default('') String confiPass,
  }) = _ChangePassState;
}
