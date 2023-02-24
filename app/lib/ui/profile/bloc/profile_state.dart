import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_state.dart';
import '../../../shared_view/app_elevated_button.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState extends BaseBlocState with _$ProfileState {
  const factory ProfileState({
    @Default(false) bool showEditName,
    @Default('') String pathAvata,
    @Default('') String name,
    @Default(AppElevatedButtonState.active) AppElevatedButtonState buttonState,
    @Default(AppElevatedButtonState.active) AppElevatedButtonState changeAvt,
  }) = _ProfileState;
}
