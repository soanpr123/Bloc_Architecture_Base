import 'package:freezed_annotation/freezed_annotation.dart';

part 'donationRecipient_entry.freezed.dart';

@freezed
class DonationRecipientEntry with _$DonationRecipientEntry {
  const factory DonationRecipientEntry({
    @Default(-1) int? id,
    @Default('') String? name,
  }) = _DonationRecipientEntry;
}
