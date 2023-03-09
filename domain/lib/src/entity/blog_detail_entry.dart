import 'package:domain/src/entity/tag_entry.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'blog_detail_entry.freezed.dart';

@freezed
class BlogsDetailEntry with _$BlogsDetailEntry {
  const factory BlogsDetailEntry({
    @Default(-1) int? id,
    @Default(AuthorEntry()) AuthorEntry? author,
    @Default('') String? categoryName,
    @Default('') String? title,
    @Default('') String? slug,
    @Default('') String? content,
    @Default('') String? url,
    @Default(0) int? totalLikes,
    @Default(0) int? totalViewed,
    @Default(0) int? totalComments,
    @Default(0) int? totalAmais,
    @Default(0) int? isLiked,
    @Default(0) int? isVotedAmai,
    @Default(false) bool? isMyPost,
    @Default(0) int? status,
    @Default('') String? createdAt,
    @Default(<TagsEntry>[]) List<TagsEntry>? tags,
  }) = _BlogsDetailEntry;
}
