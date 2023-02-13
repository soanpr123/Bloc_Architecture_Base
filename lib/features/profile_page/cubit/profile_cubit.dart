import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/component/app_elevated_button.dart';
import 'package:project/core/di/dependency_injection.dart';
import 'package:project/core/routers/router.dart';
import 'package:project/core/sevices/user_service.dart';
import 'package:project/core/utils/enum/api_request_status.dart';
import 'package:project/core/utils/toast_message.dart';
import 'package:project/features/internal_app/data/repository/internal_app_repository.dart';
import 'package:project/features/internal_app/model/profile_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit()
      : super(ProfileState(
            profile: DataProfile(),
            apiRequestStatus: APIRequestStatus.loaded,
            buttonState: AppElevatedButtonState.active,
            requestLogout: AppElevatedButtonState.active));
  final responsitory = getIt.get<InternalAppRepository>();
  Future<void> getProfile() async {
    try {
      final response = await responsitory.requestMe();
      if (response.statusCode == 200) {
        emit(state.coppyWith(profile: response.data));
      } else {
        emit(state.coppyWith(profile: DataProfile()));
      }
    } catch (e) {
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
    } catch (e) {
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
        if (context.mounted) context.router.replace(LoginRoute());
        emit(state.coppyWith(requestLogout: AppElevatedButtonState.active));
      } else {
        errorToast(msg: response.data['message']);
        emit(state.coppyWith(requestLogout: AppElevatedButtonState.active));
      }
    } catch (e) {
      emit(state.coppyWith(requestLogout: AppElevatedButtonState.active));
    }
  }

  Future<void> pickAvatarFromCamera() async {
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);

    if (image != null) {
      await uploadImage(File(image.path));
    } else {
      emit(state.coppyWith(pathAvata: "", apiRequestStatus: APIRequestStatus.error));
    }
  }

  Future<void> pickAvatarFromgallery() async {
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      await uploadImage(File(image.path));
    } else {
      emit(state.coppyWith(pathAvata: "", apiRequestStatus: APIRequestStatus.error));
    }
  }

  Future<void> uploadImage(File path) async {
    emit(state.coppyWith(apiRequestStatus: APIRequestStatus.loading));
    try {
      final response = await responsitory.uploadImage(path, "avatar");
      if (response.statusCode == 200) {
        await updateAvatar(response.data?.thumb ?? "");
      } else {
        errorToast(msg: response.message ?? "");
        emit(state.coppyWith(apiRequestStatus: APIRequestStatus.error, pathAvata: ""));
      }
    } catch (e) {
      emit(state.coppyWith(apiRequestStatus: APIRequestStatus.connectionError, pathAvata: ""));
    }
  }

  Future<void> updateAvatar(String path) async {
    final request = {"avatar": path, "about": state.profile.incognito?.about ?? ""};

    try {
      final response = await responsitory.updateMe(request);
      if (response.data['status_code'] == 200) {
        await getProfile();
        successToast(response.data['message']);
        emit(state.coppyWith(apiRequestStatus: APIRequestStatus.loaded));
      } else {
        errorToast(msg: response.data['message']);
        emit(state.coppyWith(
          apiRequestStatus: APIRequestStatus.error,
        ));
      }
    } catch (e) {
      emit(state.coppyWith(
        apiRequestStatus: APIRequestStatus.connectionError,
      ));
    }
  }
}
