import 'package:freezed_annotation/freezed_annotation.dart';

part 'amai_wiki_data_entry.freezed.dart';

@freezed
class DataWiki with _$DataWiki {
  const factory DataWiki({
    @Default('') String? title,
    String? slug,
    @Default(0) int? isRead,
    @Default('') String? createdAt,
    @Default('') String? updatedAt,
    @Default('') String? publishedAt,
  }) = _DataWiki;
}
