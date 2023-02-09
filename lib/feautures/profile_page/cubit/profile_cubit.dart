// import 'dart:html';

// import 'dart:html';

import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:project/component/app_elevated_button.dart';
import 'package:project/core/di/dependency_injection.dart';
import 'package:project/core/routers/router.gr.dart';
import 'package:project/core/sevices/user_service.dart';
import 'package:project/core/utils/toast_message.dart';
import 'package:project/feautures/internal_app/data/repository/internal_app_repository.dart';
import 'package:project/feautures/internal_app/model/profile_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit()
      : super(ProfileState(
            profile: DataProfile(),
            buttonState: AppElevatedButtonState.active,
            requestLogout: AppElevatedButtonState.active));
  final responsitory = getIt.get<InternalAppRepository>();
  Future<void> getProfile() async {
    try {
      final response = await responsitory.requestMe();
      if (response.status_code == 200) {
        emit(state.coppyWith(profile: response.data));
      } else {
        emit(state.coppyWith(profile: DataProfile()));
      }
    } on Exception catch (e) {
      emit(state.coppyWith(profile: DataProfile()));
    }
  }

  void editName(bool show) {
    // print(show);
    emit(state.coppyWith(showEditName: show));
  }

  Future<void> updateMe(String name) async {
    final request = {"name": name};
    emit(state.coppyWith(buttonState: AppElevatedButtonState.loading));
    try {
      final response = await responsitory.updateNameMe(request);
      if (response.data['status_code'] == 200) {
        await getProfile();
        successToast(response.data['message']);
        emit(state.coppyWith(showEditName: !state.showEditName, buttonState: AppElevatedButtonState.active));
      } else {
        errorToast(msg: response.data['message']);
        emit(state.coppyWith(profile: state.profile, buttonState: AppElevatedButtonState.active));
      }
    } on Exception catch (e) {
      //  errorToast(msg:translation(context).orr);
      emit(state.coppyWith(profile: state.profile, buttonState: AppElevatedButtonState.active));
    }
  }

  Future<void> logOut(BuildContext context) async {
    emit(state.coppyWith(requestLogout: AppElevatedButtonState.loading));
    try {
      final response = await responsitory.logOut();
      if (response.data['status_code'] == 200) {
        successToast(response.data['message']);
        UserService.instance.setCurrentToken("");
        context.router.replace(LoginRoute());
        emit(state.coppyWith(requestLogout: AppElevatedButtonState.active));
      } else {
        errorToast(msg: response.data['message']);
        emit(state.coppyWith(requestLogout: AppElevatedButtonState.active));
      }
    } on Exception catch (e) {
      emit(state.coppyWith(requestLogout: AppElevatedButtonState.active));
    }
  }
}
