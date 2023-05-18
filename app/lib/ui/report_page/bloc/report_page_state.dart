import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_state.dart';
import '../../../shared_view/app_elevated_button.dart';
import '../../../shared_view/body_builder.dart';

part 'report_page_state.freezed.dart';

@freezed
class ReportPageState extends BaseBlocState with _$ReportPageState {
  const factory ReportPageState({
    @Default(<ErrorTypeEntry>[]) List<ErrorTypeEntry> issue,
    @Default(<ErrorTypeEntry>[]) List<ErrorTypeEntry> issueSelect,
    @Default(APIRequestStatus.loading) APIRequestStatus loading,
    @Default(AppElevatedButtonState.inactive) AppElevatedButtonState buttonState,
    @Default(0) int count,
    @Default('') String input,
    @Default(<ImageUpload>[]) List<ImageUpload> image,
    @Default('') String errIssue,
    @Default('') String errNote,
    @Default(false) bool focusInput,
    @Default(APIRequestStatus.nodata) APIRequestStatus loadingImage,
  }) = _ReportPageState;
}
