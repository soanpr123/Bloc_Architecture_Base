import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:project/component/app_elevated_button.dart';
import 'package:project/core/di/dependency_injection.dart';
import 'package:project/core/error/exceptions.dart';
import 'package:project/core/utils/app_utils.dart';
import 'package:project/core/utils/constants.dart';
import 'package:project/feautures/internal_app/data/repository/internal_app_repository.dart';
import 'package:project/feautures/internal_app/model/login_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState(buttonState: AppElevatedButtonState.active));
  final responsitory = getIt.get<InternalAppRepository>();
  final userBox = GetIt.instance<Box>();
  Future<void> loginRequest(String email, String password) async {
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
    if (password.isEmpty) {
      emit(state.coppyWith(buttonState: AppElevatedButtonState.active, message: "Mật khẩu không được để trống"));
      return;
    }
    final request = {"email": email, "password": password};
    try {
      final response = await responsitory.loginRequest(request);
      if (response.data != null) {
        // getIt
        userBox.put("token", response.data?.accessToken ?? "");
        emit(state.coppyWith(buttonState: AppElevatedButtonState.active));
      } else {
        print("message in cubit ${response.message}");
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
}
