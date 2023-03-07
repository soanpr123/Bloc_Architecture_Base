import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_event.dart';

part 'anouncement_detail_event.freezed.dart';

abstract class AnouncementDetailEvent extends BaseBlocEvent {
  const AnouncementDetailEvent();
}

@freezed
class AnouncementPageInitiated extends AnouncementDetailEvent with _$AnouncementPageInitiated {
  const factory AnouncementPageInitiated({
    required String slungs,
  }) = _AnouncementPageInitiated;
}

@freezed
class AnouncementPageShowBack extends AnouncementDetailEvent with _$AnouncementPageShowBack {
  const factory AnouncementPageShowBack({
    @Default(false) bool show,
  }) = _AnouncementPageShowBack;
}
