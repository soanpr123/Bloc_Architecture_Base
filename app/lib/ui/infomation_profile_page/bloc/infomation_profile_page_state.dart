import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_state.dart';
import '../../../shared_view/app_elevated_button.dart';

part 'infomation_profile_page_state.freezed.dart';

@freezed
class InfomationProfilePageState extends BaseBlocState with _$InfomationProfilePageState {
  const factory InfomationProfilePageState({
    @Default(false) bool showEdit,
    @Default('') String about,
    @Default(AppElevatedButtonState.active) AppElevatedButtonState buttonState,
  }) = _InfomationProfilePageState;
}
