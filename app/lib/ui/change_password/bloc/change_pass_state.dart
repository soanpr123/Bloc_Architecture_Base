
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_state.dart';
import '../../../shared_view/app_elevated_button.dart';

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
    @Default('') String showErrPass,
     @Default('') String showErrNewPass,
      @Default('') String showConfPass,
    @Default(AppElevatedButtonState.inactive)   AppElevatedButtonState buttonState,
  }) = _ChangePassState;
}
