import 'package:freezed_annotation/freezed_annotation.dart';


import 'amai_wiki_data_entry.dart';


part 'amai_list_wiki_entry.freezed.dart';

@freezed
class ListWikiData with _$ListWikiData {
  const factory ListWikiData({
    @Default(<DataWiki>[]) List<DataWiki> notification,
    @Default(-1) int perPage,
    @Default(-1) int totalPage,
    @Default(-1) int currentPage,
    @Default(-1) int? total,
  }) = _ListWikiData;
}
