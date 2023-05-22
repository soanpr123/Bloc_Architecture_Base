
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_event.dart';

part 'ranking_page_event.freezed.dart';

abstract class RankingPageEvent extends BaseBlocEvent {
  const RankingPageEvent();
}

@freezed
class  RankingPageInitiated extends RankingPageEvent with _$RankingPageInitiated {
  const factory RankingPageInitiated() = _RankingPageInitiated;
}
