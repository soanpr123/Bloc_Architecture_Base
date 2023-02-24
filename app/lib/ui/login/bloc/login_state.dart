import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_state.dart';
import '../../../shared_view/app_elevated_button.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState extends BaseBlocState with _$LoginState {
  const factory LoginState({
    @Default('') String email,
    @Default('') String password,
    @Default(AppElevatedButtonState.inactive) AppElevatedButtonState buttonState,
    @Default(AppElevatedButtonState.inactive) AppElevatedButtonState buttonStateForgot,
    @Default(false) bool showScreen,
    @Default(true) bool obscureText,
    @Default(false) bool showView,
    @Default('') String onPageError,
    @Default(false) bool showLoginButtonLoading,
  }) = _LoginState;
}
