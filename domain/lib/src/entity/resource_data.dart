import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain.dart';
import 'donationRecipient_entry.dart';

part 'resource_data.freezed.dart';

@freezed
class ResourceDataEntry with _$ResourceDataEntry {
  const factory ResourceDataEntry({
    @Default(<CategoryPostEntry>[]) List<CategoryPostEntry>? category,
    @Default(<DonationRecipientEntry>[]) List<DonationRecipientEntry>? memberSend,
  }) = _ResourceDataEntry;
}
