import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_event.dart';

part 'login_event.freezed.dart';

abstract class LoginEvent extends BaseBlocEvent {
  const LoginEvent();
}

@freezed
class EmailTextFieldChanged extends LoginEvent with _$EmailTextFieldChanged {
  const factory EmailTextFieldChanged({
    required String email,
  }) = _EmailTextFieldChanged;
}

@freezed
class EmailTextFieldChangedForgot extends LoginEvent with _$EmailTextFieldChangedForgot {
  const factory EmailTextFieldChangedForgot({
    required String email,
  }) = _EmailTextFieldChangedForgot;
}

@freezed
class PasswordTextFieldChanged extends LoginEvent with _$PasswordTextFieldChanged {
  const factory PasswordTextFieldChanged({
    required String password,
  }) = _PasswordTextFieldChanged;
}

@freezed
class EyeIconPressed extends LoginEvent with _$EyeIconPressed {
  const factory EyeIconPressed() = _EyeIconPressed;
}

@freezed
class GotoView extends LoginEvent with _$GotoView {
  const factory GotoView() = _GotoView;
}

@freezed
class LoginButtonPressed extends LoginEvent with _$LoginButtonPressed {
  const factory LoginButtonPressed() = _LoginButtonPressed;
}

@freezed
class ForgotButtonPressed extends LoginEvent with _$ForgotButtonPressed {
  const factory ForgotButtonPressed() = _ForgotButtonPressed;
}
