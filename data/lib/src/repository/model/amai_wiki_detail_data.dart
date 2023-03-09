import 'package:freezed_annotation/freezed_annotation.dart';
part 'amai_wiki_detail_data.freezed.dart';
part 'amai_wiki_detail_data.g.dart';

@freezed
class WikiDetailData with _$WikiDetailData {
  const factory WikiDetailData({
    String? title,
    String? slug,
    String? content,
    String? thumb,
    String? url,
    @JsonKey(name: "published_at") String? publishedAt,
    @JsonKey(name: "created_at") String? createdAt,
    @JsonKey(name: "updated_at") String? updatedAt,
  }) = _WikiDetailData;

  factory WikiDetailData.fromJson(Map<String, dynamic> json) => _$WikiDetailDataFromJson(json);
}


