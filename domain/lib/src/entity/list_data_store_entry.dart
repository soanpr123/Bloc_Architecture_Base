import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain.dart';

part 'list_data_store_entry.freezed.dart';

@freezed
class ListDataStoreEntry with _$ListDataStoreEntry {
  const factory ListDataStoreEntry({
    @Default(<CanteenEntry>[]) List<CanteenEntry> canteen,
    @Default(<OtherStoreEntry>[]) List<OtherStoreEntry> other,
  }) = _ListDataStoreEntry;
}
