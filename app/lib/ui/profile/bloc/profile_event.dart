import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_event.dart';

part 'profile_event.freezed.dart';

abstract class ProfileEvent extends BaseBlocEvent {
  const ProfileEvent();
}

@freezed
class ProfilePageInitiated extends ProfileEvent with _$ProfilePageInitiated {
  const factory ProfilePageInitiated() = _ProfilePageInitiated;
}

@freezed
class ShowEditNamePressed extends ProfileEvent with _$ShowEditNamePressed {
  const factory ShowEditNamePressed() = _ShowEditNamePressed;
}

@freezed
class EditNamePressed extends ProfileEvent with _$EditNamePressed {
  const factory EditNamePressed() = _EditNamePressed;
}

@freezed
class ChosseImageFromCamera extends ProfileEvent with _$ChosseImageFromCamera {
  const factory ChosseImageFromCamera() = _ChosseImageFromCamera;
}

@freezed
class ChosseImageFromGallery extends ProfileEvent with _$ChosseImageFromGallery {
  const factory ChosseImageFromGallery() = _ChosseImageFromGallery;
}

@freezed
class LogOutRequest extends ProfileEvent with _$LogOutRequest {
  const factory LogOutRequest() = _LogOutRequest;
}

@freezed
class EditNameTextField extends ProfileEvent with _$EditNameTextField {
  const factory EditNameTextField({
    required String name,
  }) = _EditNameTextField;
}
