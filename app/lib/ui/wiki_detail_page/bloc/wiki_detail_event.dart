
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_event.dart';

part 'wiki_detail_event.freezed.dart';

abstract class WikiDetailEvent extends BaseBlocEvent {
  const WikiDetailEvent();
}

@freezed
class WikiDetailPageInitiated extends WikiDetailEvent with _$WikiDetailPageInitiated {
  const factory WikiDetailPageInitiated({
    required String slungs,
  }) = _WikiDetailPageInitiated;
}

@freezed
class WikiDetailPageShowBack extends WikiDetailEvent with _$WikiDetailPageShowBack {
  const factory WikiDetailPageShowBack({
    @Default(false) bool show,
  }) = _WikiDetailPageShowBack;
}
