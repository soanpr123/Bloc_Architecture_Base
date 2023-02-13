part of 'change_password_cubit.dart';

class ChangePasswordState extends Equatable {
  final bool showCurrentPass;
  final bool showNewPass;
  final bool showConfirmPass;
  final AppElevatedButtonState buttonState;
  const ChangePasswordState(
      {this.showCurrentPass = true,
      this.showConfirmPass = true,
      this.showNewPass = true,
      this.buttonState = AppElevatedButtonState.inactive});
  ChangePasswordState coppyWith(
      {bool? showCurrentPass, bool? showNewPass, bool? showConfirmPass, AppElevatedButtonState? buttonState}) {
    return ChangePasswordState(
        showNewPass: showNewPass ?? this.showNewPass,
        showCurrentPass: showCurrentPass ?? this.showCurrentPass,
        showConfirmPass: showConfirmPass ?? this.showConfirmPass,
        buttonState: buttonState ?? this.buttonState);
  }

  @override
  List<Object> get props => [showConfirmPass, showCurrentPass, showNewPass, buttonState];
}
