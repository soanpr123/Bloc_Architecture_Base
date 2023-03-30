import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_amai.freezed.dart';

@freezed
class HistoryAmai with _$HistoryAmai {
  const factory HistoryAmai({
    @Default(-1) int? id,
    @Default(0) int? amountAmais,
    @Default('') String? note,
    @Default('') String? createdAt,
    @Default('') String? groub,
    @Default(1) int? type,
  }) = _HistoryAmai;
}
