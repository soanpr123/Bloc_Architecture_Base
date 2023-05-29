import 'package:domain/domain.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_event.dart';

part 'report_page_event.freezed.dart';

abstract class ReportPageEvent extends BaseBlocEvent {
  const ReportPageEvent();
}

@freezed
class ReportPageInitiated extends ReportPageEvent with _$ReportPageInitiated {
  const factory ReportPageInitiated() = _ReportPageInitiated;
}

@freezed
class GetIssueReportPage extends ReportPageEvent with _$GetIssueReportPage {
  const factory GetIssueReportPage() = _GetIssueReportPage;
}

@freezed
class SelectIssueReportPage extends ReportPageEvent with _$SelectIssueReportPage {
  const factory SelectIssueReportPage({
    required ErrorTypeEntry issueSelect,
  }) = _SelectIssueReportPage;
}

@freezed
class ChangeCount extends ReportPageEvent with _$ChangeCount {
  const factory ChangeCount({
    @Default(0) int count,
  }) = _ChangeCount;
}

@freezed
class InputChange extends ReportPageEvent with _$InputChange {
  const factory InputChange({
    @Default('') String input,
  }) = _InputChange;
}

@freezed
class ChangeFocusInputText extends ReportPageEvent with _$ChangeFocusInputText {
  const factory ChangeFocusInputText({
    required bool focus,
  }) = _ChangeFocusInputText;
}

@freezed
class PickImage extends ReportPageEvent with _$PickImage {
  const factory PickImage() = _PickImage;
}

@freezed
class DeleteImage extends ReportPageEvent with _$DeleteImage {
  const factory DeleteImage({
    required int index,
  }) = _DeleteImage;
}

@freezed
class ClosePopUp extends ReportPageEvent with _$ClosePopUp {
  const factory ClosePopUp({
    required bool closePopUp,
  }) = _ClosePopUp;
}

@freezed
class ButtonSubmit extends ReportPageEvent with _$ButtonSubmit {
  const factory ButtonSubmit() = _ButtonSubmit;
}
