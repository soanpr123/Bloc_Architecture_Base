part of 'login_cubit.dart';

// part of 'login_bloc.dart';

class LoginState extends Equatable {
  final AppElevatedButtonState buttonState;
  final String message;
  // final int statusCode;
  final bool showPass;
  final bool gotoFogot;
  const LoginState({
    required this.buttonState,
    this.message = "",
    this.showPass = true,
    this.gotoFogot = false,
  });

  LoginState coppyWith({AppElevatedButtonState? buttonState, String? message, bool? showPass, bool? gotoFogot}) {
    return LoginState(
      buttonState: buttonState ?? this.buttonState,
      message: message ?? this.message,
      showPass: showPass ?? this.showPass,
      gotoFogot: gotoFogot ?? this.gotoFogot,
    );
  }

  @override
  List<Object> get props => [buttonState, message, showPass, gotoFogot];
}

// class LoginInitial extends LoginState {
//   final AppElevatedButtonState loginModel;
//   const LoginInitial({this.loginModel = AppElevatedButtonState.inactive});
//   // const LoginInitial();
// }

// class LoginError extends LoginState {
//   final AppElevatedButtonState loginModel;
//   final String message;
//   const LoginError({this.loginModel = AppElevatedButtonState.active, this.message = ""});
// }
