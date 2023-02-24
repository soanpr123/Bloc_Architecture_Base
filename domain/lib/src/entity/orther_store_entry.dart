import 'package:freezed_annotation/freezed_annotation.dart';

part 'orther_store_entry.freezed.dart';

@freezed
class OtherStoreEntry with _$OtherStoreEntry {
  const factory OtherStoreEntry({
    @Default(-1) int? id,
    @Default('') String? name,
    @Default(0) int? orderNo,
  }) = _OtherStoreEntry;
}
