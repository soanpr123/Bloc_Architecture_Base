import 'package:freezed_annotation/freezed_annotation.dart';
part 'blogs_model_data.freezed.dart';
part 'blogs_model_data.g.dart';

@freezed
class Author with _$Author {
  const factory Author({
    int? id,
    String? name,
    String? avatar,
  }) = _Author;

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);
}

@freezed
class Tags with _$Tags {
  const factory Tags({
    int? id,
    String? name,
  }) = _Tags;

  factory Tags.fromJson(Map<String, dynamic> json) => _$TagsFromJson(json);
}

@freezed
class BlogsModelData with _$BlogsModelData {
  const factory BlogsModelData({
    int? id,
    Author? author,
    @JsonKey(name: 'category_name') String? categoryName,
    String? title,
    String? slug,
    String? content,
    String? url,
    @JsonKey(name: 'total_likes') int? totalLikes,
    @JsonKey(name: 'total_viewed') int? totalViewed,
    @JsonKey(name: 'total_comments') int? totalComments,
    @JsonKey(name: 'total_amais') int? totalAmais,
    @JsonKey(name: 'is_liked') int? isLiked,
    @JsonKey(name: 'is_voted_amai') int? isVotedAmai,
    @JsonKey(name: 'is_my_post') bool? isMyPost,
    int? status,
    @JsonKey(name: 'created_at') String? createdAt,
    List<Tags>? tags,
  }) = _BlogsModelData;

  factory BlogsModelData.fromJson(Map<String, dynamic> json) => _$BlogsModelDataFromJson(json);
}
