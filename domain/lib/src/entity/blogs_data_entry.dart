import 'package:domain/src/entity/tag_entry.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'blogs_data_entry.freezed.dart';

@freezed
class BlogsDataEntry with _$BlogsDataEntry {
  const factory BlogsDataEntry({
    @Default(-1) int? id,
    @Default(AuthorEntry()) AuthorEntry? author,
    @Default('') String? title,
    @Default('') String? slug,
    @Default('') String? thumb,
    @Default(0) int? totalLikes,
    @Default(0) int? isLiked,
    @Default('') String? createdAt,
    @Default(false) bool? isMyPost,
  }) = _BlogsDataEntry;
}
