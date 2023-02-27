import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

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
    await changePass(currPas: state.currPass, newPass: state.newPass, confirmPassword: state.confiPass);
  }

  FutureOr<void> _oChangeTextPassInput(ChangePassTextInput event, Emitter<ChangePassState> emit) async {
    emit(state.copyWith(
      newPass: state.newPass,
      confiPass: state.confiPass,
      currPass: event.currentPass,
    ));
  }

  FutureOr<void> _oChangeTextNewPassInput(ChangeNewPassTextInput event, Emitter<ChangePassState> emit) async {
    emit(state.copyWith(
      newPass: event.newPass,
      confiPass: state.confiPass,
      currPass: state.currPass,
    ));
  }

  FutureOr<void> _oChangeTextConfiPassInput(ChangeConfirmPassTextInput event, Emitter<ChangePassState> emit) async {
    emit(state.copyWith(
      newPass: state.newPass,
      confiPass: event.confirmPass,
      currPass: state.currPass,
    ));
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
  }) async {
    return runBlocCatching(
        action: () async {
          final out = await _resetPasswordUseCase.execute(
            ResetPasswordInput(newPass: newPass ?? '', password: currPas ?? '', confirmPassword: confirmPassword ?? ''),
          );
          if (out.data['status_code'] == 200) {
            successToast(out.data['message']);
            await navigator.pop();
          } else {
            if (out.data['data'] != null && out.data['data']['current_password'] != null) {
              errorToast(msg: out.data['data']['current_password'].join('.'));
            } else {
              errorToast(msg: out.data['message']);
            }
          }
        },
        handleError: false,
        // ignore: prefer-trailing-comma
        doOnError: (e) async {
          errorToast(msg: exceptionMessageMapper.map(e));
        });
  }
}
