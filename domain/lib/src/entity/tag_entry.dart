import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag_entry.freezed.dart';

@freezed
class TagsEntry with _$TagsEntry {
  const factory TagsEntry({
    @Default(-1) int? id,
    @Default('') String? name,
  }) = _TagsEntry;
}

@freezed
class AuthorEntry with _$AuthorEntry {
  const factory AuthorEntry({
    @Default('') String? name,
    @Default('') String? avatar,
  }) = _AuthorEntry;
}
