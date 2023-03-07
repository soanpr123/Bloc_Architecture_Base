import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_state.dart';

part 'anouncement_detail_state.freezed.dart';

@freezed
class AnouncementDetailState extends BaseBlocState with _$AnouncementDetailState {
  const factory AnouncementDetailState({
    @Default(AnnouncementDetail()) AnnouncementDetail announcementDetail,
    @Default(false) bool show,
  }) = _AnouncementDetailState;
}
