import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_entry_data.freezed.dart';

@freezed
class BaseEntryData with _$BaseEntryData {
  const factory BaseEntryData({
    @Default('') dynamic data,
  }) = _BaseEntryData;
}
