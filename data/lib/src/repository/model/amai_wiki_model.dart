import 'package:freezed_annotation/freezed_annotation.dart';
part 'amai_wiki_model.freezed.dart';
part 'amai_wiki_model.g.dart';

@freezed
class WikiModelData2 with _$WikiModelData2 {
  const factory WikiModelData2({
    String? title,
    String? slug,
    @JsonKey(name: 'is_read') dynamic isRead,
    @JsonKey(name: 'published_at') String? publishedAt,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _WikiModelData2;

  factory WikiModelData2.fromJson(Map<String, dynamic> json) => _$WikiModelData2FromJson(json);
}

@freezed
class WikiModelData with _$WikiModelData {
  const factory WikiModelData({
    List<WikiModelData2>? data,
    @JsonKey(name: 'per_page') int? perPage,
    @JsonKey(name: 'total_page') int? totalPage,
    @JsonKey(name: 'current_page') int? currentPage,
    int? total,
  }) = _WikiModelData;

  factory WikiModelData.fromJson(Map<String, dynamic> json) => _$WikiModelDataFromJson(json);
}
