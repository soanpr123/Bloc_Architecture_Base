import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:project/component/app_elevated_button.dart';
import 'package:project/core/di/dependency_injection.dart';
import 'package:project/core/style/transaction.dart';
import 'package:project/core/utils/app_utils.dart';
import 'package:project/core/utils/toast_message.dart';

import '../../internal_app/data/repository/internal_app_repository.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(const ChangePasswordState());
  final responsitory = getIt.get<InternalAppRepository>();
  void showCurrentPass(bool show) {
    emit(state.coppyWith(showCurrentPass: show));
  }

  void showNewPass(bool show) {
    emit(state.coppyWith(showNewPass: show));
  }

  void showConfirmPass(bool show) {
    emit(state.coppyWith(showConfirmPass: show));
  }

  void checkLength(String currentPass, String newPass, String confirmPass) {
    if (newPass.isNotEmpty && currentPass.isNotEmpty && confirmPass.isNotEmpty) {
      emit(state.coppyWith(buttonState: AppElevatedButtonState.active));
    } else {
      emit(state.coppyWith(buttonState: AppElevatedButtonState.inactive));
    }
  }

  Future<void> changePassWord(String currentPass, String newPass, String confirmPass, BuildContext ctx) async {
    final request = {"current_password": currentPass, "password": newPass, "password_confirmation": confirmPass};
    emit(state.coppyWith(buttonState: AppElevatedButtonState.loading));
    if (!isPasswordValid(currentPass)) {
      emit(state.coppyWith(buttonState: AppElevatedButtonState.active));
      if (ctx.mounted) errorToast(msg: translation(ctx).password_invalid);
      return;
    }

    if (newPass != confirmPass) {
      emit(state.coppyWith(buttonState: AppElevatedButtonState.active));
      if (ctx.mounted) errorToast(msg: translation(ctx).same_pass_invalid);
      return;
    }
    if (!isPasswordValid(newPass)) {
      emit(state.coppyWith(buttonState: AppElevatedButtonState.active));
      if (ctx.mounted) errorToast(msg: translation(ctx).password_invalid);
      return;
    }
    try {
      final response = await responsitory.changePass(request);
      if (response.data['status_code'] == 200) {
        successToast(response.data['message']);
        if (ctx.mounted) ctx.router.pop();
        emit(state.coppyWith(buttonState: AppElevatedButtonState.active));
      } else {
        if (response.data['data'] != null && response.data['data']['current_password'] != null) {
         
          errorToast(msg: response.data['data']['current_password'].join('.'));
        } else {
          errorToast(msg: response.data['message']);
        }

        emit(state.coppyWith(buttonState: AppElevatedButtonState.active));
      }
    } catch (e) {
      emit(state.coppyWith(buttonState: AppElevatedButtonState.active));
    }
  }
}
