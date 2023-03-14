import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain.dart';

part 'list_member_entry.freezed.dart';

@freezed
class ListDataMemberEntry with _$ListDataMemberEntry {
  const factory ListDataMemberEntry({
    @Default(<MemberDataEntry>[]) List<MemberDataEntry> memmber,
   @Default(-1) int? perPage,
    @Default(-1) int? totalPage,
  @Default(-1) int? currentPage,
  }) = _ListDataMemberEntry;
}
