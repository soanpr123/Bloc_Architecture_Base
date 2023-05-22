import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_state.dart';
import '../../../shared_view/body_builder.dart';

part 'ranking_page_state.freezed.dart';

@freezed
class RankingPageState extends BaseBlocState with _$RankingPageState {
  const factory RankingPageState({
    @Default(<RankingDataEntry>[]) List<RankingDataEntry> leaderBroad,
    @Default(APIRequestStatus.loading) APIRequestStatus apiRequestStatus,
  }) = _RankingPageState;
}
