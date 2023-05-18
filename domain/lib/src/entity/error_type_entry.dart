import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_type_entry.freezed.dart';

@freezed
class ErrorTypeEntry with _$ErrorTypeEntry {
  const factory ErrorTypeEntry({
    @Default(-1) int? id,
    @Default('') String? name,
  }) = _ErrorTypeEntry;
}
