import 'package:freezed_annotation/freezed_annotation.dart';
part 'history_amai_data.freezed.dart';
part 'history_amai_data.g.dart';

@freezed
class Data2HistoryAmai with _$Data2HistoryAmai {
  const factory Data2HistoryAmai({
    int? id,
    @JsonKey(name: 'amount_amais') int? amountAmais,
    String? note,
    @JsonKey(name: 'created_at') String? createdAt,
    int? type,
  }) = _Data2HistoryAmai;

  factory Data2HistoryAmai.fromJson(Map<String, dynamic> json) => _$Data2HistoryAmaiFromJson(json);
}

@freezed
class HistoryAmaiData with _$HistoryAmaiData {
  const factory HistoryAmaiData({
    List<Data2HistoryAmai>? data,
    @JsonKey(name: 'status_code') int? perPage,
    String? message,
    dynamic errors,
  }) = _HistoryAmaiData;

  factory HistoryAmaiData.fromJson(Map<String, dynamic> json) => _$HistoryAmaiDataFromJson(json);
}
