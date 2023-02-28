import 'package:freezed_annotation/freezed_annotation.dart';

import 'history_amai.dart';

part 'history_amai_list.freezed.dart';

@freezed
class HistoryAmaiList with _$HistoryAmaiList {
  const factory HistoryAmaiList({
    @Default(<HistoryAmai>[]) List<HistoryAmai> notification,
  }) = _HistoryAmaiList;
}
