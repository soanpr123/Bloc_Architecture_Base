import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';

import '../../../base/bloc/base_state.dart';

part 'history_amai_state.freezed.dart';

@freezed
class HistoryAmaiState extends BaseBlocState with _$HistoryAmaiState {
  factory HistoryAmaiState({
    @Default(<HistoryAmai>[]) List<HistoryAmai> history,
    @Default(false) bool isShimmerLoading,
    AppException? loadUsersException,
    @Default(true) bool enablePullNotifi,
    @Default(1) int page,
  }) = _HistoryAmaiState;
}
