import 'package:freezed_annotation/freezed_annotation.dart';

import 'history_amai.dart';

part 'history_amai_list.freezed.dart';

@freezed
class HistoryAmaiList with _$HistoryAmaiList {
  const factory HistoryAmaiList({
    @Default(<HistoryAmai>[]) List<HistoryAmai> notification,
    @Default(-1) int perPage,
    @Default(-1) int totalPage,
    @Default(-1) int currentPage,
    @Default(-1) int? total,
  }) = _HistoryAmaiList;
}
