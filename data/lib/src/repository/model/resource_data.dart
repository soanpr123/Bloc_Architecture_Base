import 'package:freezed_annotation/freezed_annotation.dart';
part 'resource_data.freezed.dart';
part 'resource_data.g.dart';

@freezed
class CategoryPosts with _$CategoryPosts {
  const factory CategoryPosts({
    int? id,
    String? slug,
    String? name,
  }) = _CategoryPosts;

  factory CategoryPosts.fromJson(Map<String, dynamic> json) => _$CategoryPostsFromJson(json);
}

@freezed
class ResourceData with _$ResourceData {
  const factory ResourceData({
    @JsonKey(name: 'category_posts') List<CategoryPosts>? categoryPosts,
  }) = _ResourceData;

  factory ResourceData.fromJson(Map<String, dynamic> json) => _$ResourceDataFromJson(json);
}


