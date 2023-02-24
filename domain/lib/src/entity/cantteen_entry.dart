import 'package:freezed_annotation/freezed_annotation.dart';

part 'cantteen_entry.freezed.dart';

@freezed
class CanteenEntry with _$CanteenEntry {
  const factory CanteenEntry({
    @Default(-1) int? id,
    @Default('') String? name,
    @Default(0) int? orderNo,
  }) = _CanteenEntry;
}
