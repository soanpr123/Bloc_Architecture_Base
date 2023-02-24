import 'dart:async';
import 'dart:io';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../../../app.dart';
import '../../../utils/toast_message.dart';

@Injectable()
class ProfileBloc extends BaseBloc<ProfileEvent, ProfileState> {
  ProfileBloc(this._logoutUseCase, this._updateMeNameUseCase, this._updateMeUseCase, this._uploadImageuseCase)
      : super(const ProfileState()) {
    on<ProfilePageInitiated>(
      _onMainPageInitiated,
      transformer: log(),
    );
    on<ShowEditNamePressed>(
      _onShowEdirname,
      transformer: log(),
    );

    on<EditNameTextField>(
      _onNameTextFieldChanged,
      transformer: log(),
    );

    on<EditNamePressed>(
      _onEditNamePressed,
      transformer: log(),
    );

    on<ChosseImageFromCamera>(
      pickAvatarFromCamera,
      transformer: log(),
    );

    on<ChosseImageFromGallery>(
      pickAvatarFromGallery,
      transformer: log(),
    );

    on<LogOutRequest>(
      _onLogOutPressed,
      transformer: log(),
    );
  }
  final UpdateMeUseCase _updateMeUseCase;
  final UpdateMeNameUseCase _updateMeNameUseCase;
  final LogoutUseCase _logoutUseCase;
  final UploadImageUseCase _uploadImageuseCase;
  FutureOr<void> _onMainPageInitiated(ProfilePageInitiated event, Emitter<ProfileState> emit) async {}

  void _onShowEdirname(ShowEditNamePressed event, Emitter<ProfileState> emit) {
    emit(state.copyWith(showEditName: !state.showEditName));
  }

  void _onNameTextFieldChanged(EditNameTextField event, Emitter<ProfileState> emit) {
    emit(state.copyWith(
      name: event.name,
    ));
  }

  Future<void> pickAvatarFromCamera(ChosseImageFromCamera event, Emitter<ProfileState> emit) async {
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);

    if (image != null) {
      await _updateloadImage(emit: emit, avt: File(image.path));
    } else {
      emit(state.copyWith(pathAvata: '', changeAvt: AppElevatedButtonState.active));
    }
  }

  Future<void> pickAvatarFromGallery(ChosseImageFromGallery event, Emitter<ProfileState> emit) async {
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      await _updateloadImage(emit: emit, avt: File(image.path));
    } else {
      emit(state.copyWith(pathAvata: '', changeAvt: AppElevatedButtonState.active));
    }
  }

  FutureOr<void> _onEditNamePressed(EditNamePressed event, Emitter<ProfileState> emit) async {
    await _updateMe(
      emit: emit,
      name: state.name,
    );
  }

  FutureOr<void> _onLogOutPressed(LogOutRequest event, Emitter<ProfileState> emit) async {
    return runBlocCatching(
      action: () async {
        final out = await _logoutUseCase.execute(const LogoutInput());

        if (out.data['status_code'] == 200) {
          commonBloc.add(const ForceLogoutButtonPressed());
        } else {
          errorToast(msg: out.data['message']);
        }
      },
      doOnSubscribe: () async => emit(state.copyWith(buttonState: AppElevatedButtonState.loading)),
      doOnSuccessOrError: () async => emit(state.copyWith(buttonState: AppElevatedButtonState.active)),
      handleLoading: false,
    );
  }

  Future<void> _updateMe({required Emitter<ProfileState> emit, String? name}) async {
    return runBlocCatching(
      action: () async {
        final out = await _updateMeNameUseCase.execute(UpdateMeNameInput(name: name ?? ''));

        if (out.data['status_code'] == 200) {
          appBloc.add(const AppInitiated());
          emit(state.copyWith(showEditName: !state.showEditName));
          successToast(out.data['message']);
        } else {
          errorToast(msg: out.data['message']);
        }
      },
      doOnSubscribe: () async => emit(state.copyWith(buttonState: AppElevatedButtonState.loading)),
      doOnSuccessOrError: () async => emit(state.copyWith(buttonState: AppElevatedButtonState.active)),
      handleLoading: false,
    );
  }

  Future<void> _updateloadImage({required Emitter<ProfileState> emit, required File avt}) async {
    return runBlocCatching(
      action: () async {
        final out = await _uploadImageuseCase.execute(UploadImageInput(file: avt, type: 'avatar'));

        if (out.statusCode == 200) {
          await _updateAvt(emit: emit, avt: out.url);
        } else {
          errorToast(msg: out.message);
        }
      },
      doOnSubscribe: () async => emit(state.copyWith(changeAvt: AppElevatedButtonState.loading)),
      doOnSuccessOrError: () async => emit(state.copyWith(changeAvt: AppElevatedButtonState.active)),
      handleLoading: false,
    );
  }

  Future<void> _updateAvt({required Emitter<ProfileState> emit, required String avt}) async {
    return runBlocCatching(
      action: () async {
        final out = await _updateMeUseCase
            .execute(UpdateMeInput(avt: avt, about: commonBloc.state.users.incognito?.about ?? ''));

        if (out.data['status_code'] == 200) {
          successToast(out.data['message']);
          appBloc.add(const AppInitiated());
        } else {
          errorToast(msg: out.data['message']);
        }
      },
      doOnSubscribe: () async => emit(state.copyWith(changeAvt: AppElevatedButtonState.loading)),
      doOnSuccessOrError: () async => emit(state.copyWith(changeAvt: AppElevatedButtonState.active)),
      handleLoading: false,
    );
  }
}
