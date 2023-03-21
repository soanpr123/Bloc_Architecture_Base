import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain.dart';

part 'list_blogs_data_entry.freezed.dart';

@freezed
class ListBlogsDataEntry with _$ListBlogsDataEntry {
  const factory ListBlogsDataEntry({
    @Default(<BlogsDataEntry>[]) List<BlogsDataEntry> blogs,
    @Default(-1) int perPage,
    @Default(-1) int totalPage,
    @Default(-1) int currentPage,
    @Default(-1) int? total,
  }) = _ListBlogsDataEntry;
}
