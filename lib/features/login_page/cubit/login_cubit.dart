import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:project/component/app_elevated_button.dart';
import 'package:project/component/custom_alert.dart';
import 'package:project/core/di/dependency_injection.dart';
import 'package:project/core/error/exceptions.dart';
import 'package:project/core/routers/router.dart';

import 'package:project/core/sevices/user_service.dart';
import 'package:project/core/style/text_style.dart';
import 'package:project/core/style/transaction.dart';
import 'package:project/core/utils/app_utils.dart';
import 'package:project/core/utils/constants.dart';
import 'package:project/features/internal_app/data/repository/internal_app_repository.dart';
// import 'package:project/features/internal_app/model/login_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState(buttonState: AppElevatedButtonState.active));
  final responsitory = getIt.get<InternalAppRepository>();
  final userBox = GetIt.instance<Box>();
  final tokenBox = GetIt.I<Box<String>>();
  Future<void> loginRequest(BuildContext context, String email, String password) async {
    emit(state.coppyWith(buttonState: AppElevatedButtonState.loading, message: ""));
    // await Future.delayed(const Duration(seconds: 15));
    if (email.isEmpty) {
      emit(state.coppyWith(
        buttonState: AppElevatedButtonState.active,
        message: translation(context).email_blank,
      ));
      return;
    }
    if (checkFormat(regexEmail, email) == false) {
      emit(state.coppyWith(
        buttonState: AppElevatedButtonState.active,
        message: translation(context).email_invalid,
      ));
      return;
    }
    if (password.isEmpty) {
      emit(state.coppyWith(
        buttonState: AppElevatedButtonState.active,
        message: translation(context).password_blank,
      ));
      return;
    }
    final request = {"email": email, "password": password};
    try {
      final response = await responsitory.loginRequest(request);
      if (response.data != null) {
        UserService.instance.setCurrentToken(response.data?.accessToken ?? "");
        // ignore: use_build_context_synchronously
        context.router.replace(const MainRoute());
        emit(state.coppyWith(buttonState: AppElevatedButtonState.active));
      } else {
        emit(state.coppyWith(buttonState: AppElevatedButtonState.active, message: response.message ?? ""));
      }
    } catch (e) {
      emit(state.coppyWith(buttonState: AppElevatedButtonState.active, message: e.toString()));
      const ServerException();
    }
  }

  void showPassword(bool show) {
    // print(state.showPass);
    emit(state.coppyWith(showPass: show, message: "", buttonState: AppElevatedButtonState.active));
  }

  void gotoFogot(bool show) {
    // print(state.showPass);
    emit(state.coppyWith(gotoFogot: show, message: "", buttonState: AppElevatedButtonState.active));
  }

  Future<void> forgetRequest(String email, BuildContext context) async {
    emit(state.coppyWith(buttonState: AppElevatedButtonState.loading, message: ""));
    // await Future.delayed(const Duration(seconds: 15));
    if (email.isEmpty) {
      emit(state.coppyWith(buttonState: AppElevatedButtonState.active, message: "Email không được để trống"));
      return;
    }
    if (checkFormat(regexEmail, email) == false) {
      emit(state.coppyWith(buttonState: AppElevatedButtonState.active, message: "Email không đúng định dạng"));
      return;
    }

    final request = {
      "email": email,
    };
    try {
      final response = await responsitory.requestForget(request);
      // print();
      if (response.data['status_code'] == 200) {
        // getIt
        showDialog(
            context: (context),
            builder: (co) {
              return CustomAlert(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Column(children: [
                    Text(
                      response.data["message"],
                      textAlign: TextAlign.center,
                      style: typoInterNomal14,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    AppElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        gotoFogot(false);
                      },
                      buttonTitle: "Xác nhận",
                    )
                  ]),
                ),
              );
            });

        emit(state.coppyWith(buttonState: AppElevatedButtonState.active));
      } else {
        // print("message in cubit ${response.data["message"]}");
        emit(state.coppyWith(buttonState: AppElevatedButtonState.active, message: response.data["message"]));
      }
    } catch (e) {
      emit(state.coppyWith(buttonState: AppElevatedButtonState.active, message: e.toString()));
      const ServerException();
    }
  }
}
