import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../app.dart';
import '../../../utils/toast_message.dart';

@Injectable()
class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  LoginBloc(this._loginUseCase, this._forgotPasswordUseCase) : super(const LoginState()) {
    on<EyeIconPressed>(
      _onEyeIconPressed,
      transformer: log(),
    );

    on<GotoView>(
      _onGotoViewPressed,
      transformer: log(),
    );

    on<EmailTextFieldChanged>(
      _onEmailTextFieldChanged,
      transformer: log(),
    );
    on<PasswordTextFieldChanged>(
      _onPasswordTextFieldChanged,
      transformer: log(),
    );

    on<LoginButtonPressed>(
      _onLoginButtonPressed,
      transformer: log(),
    );

    on<EmailTextFieldChangedForgot>(
      _onEmailTextFieldChangedForgot,
      transformer: log(),
    );
    on<ForgotButtonPressed>(
      _onForgotButtonPressed,
      transformer: log(),
    );
  }
  final LoginUseCase _loginUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  AppElevatedButtonState _isLoginButtonEnabled(String email, String password) {
    return email.isNotEmpty && password.isNotEmpty ? AppElevatedButtonState.active : AppElevatedButtonState.inactive;
  }

  AppElevatedButtonState _isLoginButtonEnabledForgot(String email) {
    return email.isNotEmpty ? AppElevatedButtonState.active : AppElevatedButtonState.inactive;
  }

  void _onEyeIconPressed(EyeIconPressed event, Emitter<LoginState> emit) {
    emit(state.copyWith(obscureText: !state.obscureText));
  }

  void _onGotoViewPressed(GotoView event, Emitter<LoginState> emit) {
    emit(state.copyWith(showView: !state.showView));
  }

  void _onEmailTextFieldChanged(EmailTextFieldChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      email: event.email,
      buttonState: _isLoginButtonEnabled(event.email, state.password),
    ));
  }

  void _onEmailTextFieldChangedForgot(EmailTextFieldChangedForgot event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      email: event.email,
      buttonStateForgot: _isLoginButtonEnabledForgot(
        event.email,
      ),
    ));
  }

  void _onPasswordTextFieldChanged(PasswordTextFieldChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      password: event.password,
      buttonState: _isLoginButtonEnabled(state.email, event.password),
    ));
  }

  FutureOr<void> _onLoginButtonPressed(LoginButtonPressed event, Emitter<LoginState> emit) {
    return runBlocCatching(
      doOnSubscribe: () async => emit(state.copyWith(buttonState: AppElevatedButtonState.loading, onPageError: '')),
      action: () async {
        final out = await _loginUseCase.execute(LoginInput(email: state.email, password: state.password));
        if (out.statusCode == 200) {
          await navigator.replace(const AppRouteInfo.main());
        } else {
          errorToast(msg: out.message);
          // showToast();
        }

        // print()
      },
      handleError: false,
      doOnError: (e) async {
        print(e);

        if (e.appExceptionType == AppExceptionType.validation) {
          emit(state.copyWith(onPageError: exceptionMessageMapper.map(e)));
        } else {
          errorToast(msg: exceptionMessageMapper.map(e));
        }
      },
      doOnSuccessOrError: () async {
        emit(state.copyWith(buttonState: AppElevatedButtonState.active));
      },
      handleLoading: false,
    );
  }

  FutureOr<void> _onForgotButtonPressed(ForgotButtonPressed event, Emitter<LoginState> emit) {
    return runBlocCatching(
      doOnSubscribe: () async => emit(state.copyWith(buttonStateForgot: AppElevatedButtonState.loading)),
      action: () async {
        final out = await _forgotPasswordUseCase.execute(ForgotPasswordInput(
          email: state.email,
        ));
        if (out.data['status_code'] == 200) {
          successToast(out.data['message']);
        } else {
          if (out.data['data'] != null && out.data['data']['email'] != null) {
            errorToast(msg: out.data['data']['email'].join(',').toString());
          } else {
            errorToast(msg: out.data['message'].toString());
          }
        }
        // await navigator.replace(const AppRouteInfo.main());
        // print()
      },
      handleError: false,
      doOnError: (e) async {
        errorToast(msg: exceptionMessageMapper.map(e));
        if (e.appExceptionType == AppExceptionType.validation) {
          emit(state.copyWith(onPageError: exceptionMessageMapper.map(e)));
        }
      },
      doOnSuccessOrError: () async {
        emit(state.copyWith(buttonStateForgot: AppElevatedButtonState.active));
      },
      handleLoading: false,
    );
  }
}
