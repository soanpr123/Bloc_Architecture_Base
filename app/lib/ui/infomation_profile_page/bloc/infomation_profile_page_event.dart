import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_event.dart';

part 'infomation_profile_page_event.freezed.dart';

abstract class InfomationProfilePageEvent extends BaseBlocEvent {
  const InfomationProfilePageEvent();
}

@freezed
class InfomationProfilePageInitiated extends InfomationProfilePageEvent with _$InfomationProfilePageInitiated {
  const factory InfomationProfilePageInitiated() = _InfomationProfilePageInitiated;
}

@freezed
class InfomationProfilePageTextfieldInput extends InfomationProfilePageEvent
    with _$InfomationProfilePageTextfieldInput {
  const factory InfomationProfilePageTextfieldInput({
    required String text,
  }) = _InfomationProfilePageTextfieldInput;
}

@freezed
class InfomationProfileShowEditInput extends InfomationProfilePageEvent with _$InfomationProfileShowEditInput {
  const factory InfomationProfileShowEditInput({
    required bool show,
  }) = _InfomationProfileShowEditInput;
}
