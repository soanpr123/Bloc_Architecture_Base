import 'package:freezed_annotation/freezed_annotation.dart';

part 'ranking_data_entry.freezed.dart';

@freezed
class RankingDataEntry with _$RankingDataEntry {
  const factory RankingDataEntry({
    @Default(-1) int? id,
    @Default('') String? name,
    @Default('') String? avatar,
    @Default(0) int? totalLikes,
    @Default(0) int? direction,
  }) = _RankingDataEntry;
}
