import 'package:freezed_annotation/freezed_annotation.dart';
part 'ranking_data.freezed.dart';
part 'ranking_data.g.dart';

@freezed
class RankingData with _$RankingData {
  const factory RankingData({
    int? id,
    String? name,
    String? avatar,
    @JsonKey(name: "total_likes") int? totalLikes,
    int? direction,
  }) = _RankingData;

  factory RankingData.fromJson(Map<String, dynamic> json) => _$RankingDataFromJson(json);
}


