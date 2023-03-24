import 'package:freezed_annotation/freezed_annotation.dart';

part 'popup_donate_entry.freezed.dart';

@freezed
class PopUpDonateEntry with _$PopUpDonateEntry {
  const factory PopUpDonateEntry({
    @Default('') String donor,
    @Default(1) int amountAmais,
    @Default('') String note,
  }) = _PopUpDonateEntry;
}
