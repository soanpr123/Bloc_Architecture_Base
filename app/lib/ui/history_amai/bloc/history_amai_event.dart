

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../base/bloc/base_event.dart';

part 'history_amai_event.freezed.dart';

abstract class HistoryAmaiEvent extends BaseBlocEvent {
  const HistoryAmaiEvent();
}

@freezed
class HistoryPageInitiated extends HistoryAmaiEvent with _$HistoryPageInitiated {
  const factory HistoryPageInitiated() = _HistoryPageInitiated;
}

@freezed
class AmaiHistoryPageRefreshed extends HistoryAmaiEvent with _$AmaiHistoryPageRefreshed {
  const factory AmaiHistoryPageRefreshed({
    required RefreshController completer,
  }) = _AmaiHistoryPageRefreshed;
}

@freezed
class AmaiHistoryLoadMore extends HistoryAmaiEvent with _$AmaiHistoryLoadMore {
  const factory AmaiHistoryLoadMore({
     required RefreshController completer,
  }) = _AmaiHistoryLoadMore;
}
