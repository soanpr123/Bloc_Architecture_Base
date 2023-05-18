import 'package:freezed_annotation/freezed_annotation.dart';
part 'resource_data.freezed.dart';
part 'resource_data.g.dart';

@freezed
class CategoryPosts with _$CategoryPosts {
  const factory CategoryPosts({
    int? id,
    String? slug,
    String? name,
  }) = _CategoryPosts;

  factory CategoryPosts.fromJson(Map<String, dynamic> json) => _$CategoryPostsFromJson(json);
}

@freezed
class DonationRecipient with _$DonationRecipient {
  const factory DonationRecipient({
    int? id,
    String? name,
  }) = _DonationRecipient;

  factory DonationRecipient.fromJson(Map<String, dynamic> json) => _$DonationRecipientFromJson(json);
}

@freezed
class ErrorTypes with _$ErrorTypes {
  const factory ErrorTypes({
    int? id,
    String? name,
  }) = _ErrorTypes;

  factory ErrorTypes.fromJson(Map<String, dynamic> json) => _$ErrorTypesFromJson(json);
}

@freezed
class ResourceData with _$ResourceData {
  const factory ResourceData({
    @JsonKey(name: 'category_posts') List<CategoryPosts>? categoryPosts,
    @JsonKey(name: 'donation_recipient') List<DonationRecipient>? donationRecipient,
    @JsonKey(name: 'error_types') List<ErrorTypes>? errorTypes,
  }) = _ResourceData;

  factory ResourceData.fromJson(Map<String, dynamic> json) => _$ResourceDataFromJson(json);
}
