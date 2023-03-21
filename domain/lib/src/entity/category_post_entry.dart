import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_post_entry.freezed.dart';

@freezed
class CategoryPostEntry with _$CategoryPostEntry {
  const factory CategoryPostEntry({
    @Default(-1) int? id,
    @Default('') String? slug,
    @Default('') String? name,
  }) = _CategoryPostEntry;
}
