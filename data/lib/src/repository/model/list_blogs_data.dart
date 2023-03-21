import 'package:freezed_annotation/freezed_annotation.dart';

import 'blogs_model_data.dart';
part 'list_blogs_data.freezed.dart';
part 'list_blogs_data.g.dart';



@freezed
class ListBlogsData2 with _$ListBlogsData2 {
  const factory ListBlogsData2({
    int? id,
    Author? author,
    String? title,
    String? slug,
    String? thumb,
    @JsonKey(name: 'total_likes') int? totalLikes,
    @JsonKey(name: 'is_liked') int? isLiked,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'is_my_post') bool? isMyPost,
  }) = _ListBlogsData2;

  factory ListBlogsData2.fromJson(Map<String, dynamic> json) => _$ListBlogsData2FromJson(json);
}

@freezed
class ListBlogsData with _$ListBlogsData {
  const factory ListBlogsData({
    List<_ListBlogsData2>? data,
    @JsonKey(name: 'per_page') int? perPage,
    @JsonKey(name: 'total_page') int? totalPage,
    @JsonKey(name: 'current_page') int? currentPage,
    int? total,
  }) = _ListBlogsData;

  factory ListBlogsData.fromJson(Map<String, dynamic> json) => _$ListBlogsDataFromJson(json);
}
