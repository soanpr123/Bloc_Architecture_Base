import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

import '../../../app.dart';
import '../../../utils/toast_message.dart';
import 'change_pass_event.dart';
import 'change_pass_state.dart';

@Injectable()
class ChangePassBloc extends BaseBloc<ChangePassEvent, ChangePassState> {
  ChangePassBloc(this._resetPasswordUseCase) : super(const ChangePassState()) {
    on<ChangePassPageInitiated>(
      _onMainPageInitiated,
      transformer: log(),
    );

    on<ChangePassPress>(
      _oChangePassPress,
      transformer: log(),
    );

    on<ChangePassTextInput>(
      _oChangeTextPassInput,
      transformer: log(),
    );
    on<ChangeNewPassTextInput>(
      _oChangeTextNewPassInput,
      transformer: log(),
    );
    on<ChangeConfirmPassTextInput>(
      _oChangeTextConfiPassInput,
      transformer: log(),
    );
    on<ShowPassPress>(
      _onShowPassPress,
      transformer: log(),
    );
    on<ShowNewPassPress>(
      _onShowNewPassPress,
      transformer: log(),
    );
    on<ShowConfiPassPress>(
      _onShowConfPassPress,
      transformer: log(),
    );
  }

  final ResetPasswordUseCase _resetPasswordUseCase;
  FutureOr<void> _onMainPageInitiated(ChangePassPageInitiated event, Emitter<ChangePassState> emit) async {
    // await _getTotal(emit: emit);
  }

  FutureOr<void> _oChangePassPress(ChangePassPress event, Emitter<ChangePassState> emit) async {
    if (!ValidationUtils.isPasswordValidExp(state.currPass) && state.currPass.length < 8) {
      emit(
        state.copyWith(
          showErrPass: S.current.password_invalid,
          showErrNewPass: state.showErrNewPass,
          showConfPass: state.showConfPass,
        ),
      );

      return;
    } else {
      emit(state.copyWith(showErrPass: '', showErrNewPass: state.showErrNewPass, showConfPass: state.showConfPass));
    }
    if (!ValidationUtils.isPasswordValidExp(state.newPass) && state.newPass.length < 8) {
      emit(state.copyWith(
        showErrPass: state.showErrPass,
        showErrNewPass: S.current.password_invalid,
        showConfPass: state.showConfPass,
      ));

      return;
    } else {
      emit(state.copyWith(
        showErrPass: state.showErrPass,
        showErrNewPass: '',
        showConfPass: state.showConfPass,
      ));
    }
    if (!ValidationUtils.isPasswordValidExp(state.confiPass) && state.confiPass.length < 8) {
      emit(state.copyWith(
        showErrPass: state.showErrPass,
        showErrNewPass: state.showErrNewPass,
        showConfPass: S.current.password_invalid,
      ));

      return;
    } else {
      emit(state.copyWith(
        showErrPass: state.showErrPass,
        showErrNewPass: state.showErrNewPass,
        showConfPass: '',
      ));
    }
    if (state.newPass != state.currPass) {
      errorToast(msg: S.current.same_pass_invalid);

      return;
    }
    await changePass(currPas: state.currPass, newPass: state.newPass, confirmPassword: state.confiPass, emit: emit);
  }

  FutureOr<void> _oChangeTextPassInput(ChangePassTextInput event, Emitter<ChangePassState> emit) async {
    emit(state.copyWith(
      newPass: state.newPass,
      confiPass: state.confiPass,
      currPass: event.currentPass,
      buttonState: _isLoginButtonEnabled(event.currentPass, state.newPass, state.confiPass),
    ));
  }

  FutureOr<void> _oChangeTextNewPassInput(ChangeNewPassTextInput event, Emitter<ChangePassState> emit) async {
    emit(state.copyWith(
      newPass: event.newPass,
      confiPass: state.confiPass,
      currPass: state.currPass,
      buttonState: _isLoginButtonEnabled(state.currPass, event.newPass, state.confiPass),
    ));
  }

  FutureOr<void> _oChangeTextConfiPassInput(ChangeConfirmPassTextInput event, Emitter<ChangePassState> emit) async {
    emit(state.copyWith(
      newPass: state.newPass,
      confiPass: event.confirmPass,
      currPass: state.currPass,
      buttonState: _isLoginButtonEnabled(state.currPass, state.newPass, event.confirmPass),
    ));
  }

  AppElevatedButtonState _isLoginButtonEnabled(String Pass, String NewPass, String confirmPas) {
    return Pass.isNotEmpty && NewPass.isNotEmpty && confirmPas.isNotEmpty
        ? AppElevatedButtonState.active
        : AppElevatedButtonState.inactive;
  }

  FutureOr<void> _onShowPassPress(ShowPassPress event, Emitter<ChangePassState> emit) async {
    emit(state.copyWith(
      showCurrentPass: event.showCurr,
      showConfirmPass: state.showConfirmPass,
      showNewPass: state.showNewPass,
    ));
  }

  FutureOr<void> _onShowNewPassPress(ShowNewPassPress event, Emitter<ChangePassState> emit) async {
    emit(state.copyWith(
      showCurrentPass: state.showCurrentPass,
      showConfirmPass: state.showConfirmPass,
      showNewPass: event.showNew,
    ));
  }

  FutureOr<void> _onShowConfPassPress(ShowConfiPassPress event, Emitter<ChangePassState> emit) async {
    emit(state.copyWith(
      showCurrentPass: state.showCurrentPass,
      showConfirmPass: event.showConf,
      showNewPass: state.showNewPass,
    ));
  }

  Future<void> changePass({
    String? currPas,
    String? newPass,
    String? confirmPassword,
    required Emitter<ChangePassState> emit,
  }) async {
    return runBlocCatching(
        doOnSubscribe: () async {
          emit(state.copyWith(buttonState: AppElevatedButtonState.loading));
        },
        action: () async {
          final out = await _resetPasswordUseCase.execute(
            ResetPasswordInput(newPass: newPass ?? '', password: currPas ?? '', confirmPassword: confirmPassword ?? ''),
          );
          if (out.data['status_code'] == 200) {
            emit(state.copyWith(buttonState: AppElevatedButtonState.inactive));
            successToast(out.data['message'].toString());
            await navigator.pop();
          } else {
            emit(state.copyWith(buttonState: AppElevatedButtonState.active));
            if (out.data['data'] != null && out.data['data']['current_password'] != null) {
              errorToast(msg: out.data['data']['current_password'].join('.').toString());
            } else {
              errorToast(msg: out.data['message'].toString());
            }
          }
        },
        handleError: false,
        handleLoading: false,
        // ignore: prefer-trailing-comma
        doOnError: (e) async {
          emit(state.copyWith(buttonState: AppElevatedButtonState.active));
          errorToast(msg: exceptionMessageMapper.map(e));
        });
  }
}
