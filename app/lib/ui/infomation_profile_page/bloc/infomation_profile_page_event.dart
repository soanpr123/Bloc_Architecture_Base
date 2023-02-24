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
