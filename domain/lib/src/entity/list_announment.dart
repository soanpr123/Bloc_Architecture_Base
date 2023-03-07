import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain.dart';
import 'data_announment.dart';

part 'list_announment.freezed.dart';

@freezed
class ListAnnoument with _$ListAnnoument {
  const factory ListAnnoument({
    @Default(<DataAnnoument>[]) List<DataAnnoument> notification,
    @Default(-1) int perPage,
    @Default(-1) int totalPage,
    @Default(-1) int currentPage,
    @Default(-1) int? total,
  }) = _ListAnnoument;
}
