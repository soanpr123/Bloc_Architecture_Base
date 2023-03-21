import 'package:freezed_annotation/freezed_annotation.dart';
part 'profile_data.freezed.dart';
part 'profile_data.g.dart';

@freezed
class SocialsData with _$SocialsData {
  const factory SocialsData({
    @JsonKey(name: 'facebook_url') String? facebookUrl,
    @JsonKey(name: 'facebook_username') String? facebookUsername,
    @JsonKey(name: 'telegram_url') String? telegramUrl,
    @JsonKey(name: 'telegram_username') String? telegramUsername,
  }) = _SocialsData;

  factory SocialsData.fromJson(Map<String, dynamic> json) => _$SocialsDataFromJson(json);
}

@freezed
class EducationData with _$EducationData {
  const factory EducationData({
    int? graded,
    @JsonKey(name: 'graded_name') String? gradedName,
    String? gpa,
    @JsonKey(name: 'gpa_format') String? gpaFormat,
    @JsonKey(name: 'university_code') String? universityCode,
    @JsonKey(name: 'university_name') String? universityName,
  }) = _EducationData;

  factory EducationData.fromJson(Map<String, dynamic> json) => _$EducationDataFromJson(json);
}

@freezed
class BankData with _$BankData {
  const factory BankData({
    @JsonKey(name: 'account_number') String? accountNumber,
    String? bank,
    @JsonKey(name: 'bank_agency') String? bankAgency,
    String? name,
    @JsonKey(name: 'short_name') String? shortName,
  }) = _BankData;

  factory BankData.fromJson(Map<String, dynamic> json) => _$BankDataFromJson(json);
}

@freezed
class IncognitoData with _$IncognitoData {
  const factory IncognitoData({
    int? id,
    String? name,
    String? avatar,
    String? about,
  }) = _IncognitoData;

  factory IncognitoData.fromJson(Map<String, dynamic> json) => _$IncognitoDataFromJson(json);
}

@freezed
class ProfileData with _$ProfileData {
  const factory ProfileData({
    int? id,
    @JsonKey(name: 'position_id') int? positionId,
    @JsonKey(name: 'position_name') String? positionName,
    String? name,
    String? email,
    String? phone,
    @JsonKey(name: 'personal_email') String? personalEmail,
    @JsonKey(name: 'gender_id') int? genderId,
    String? gender,
    String? dob,
    String? avatar,
    String? address,
    dynamic about,
    @JsonKey(name: 'citizen_id') String? citizenId,
    @JsonKey(name: 'last_online_at') String? lastOnlineAt,
    @JsonKey(name: 'join_company_at') String? joinCompanyAt,
    @JsonKey(name: 'up_official_at') String? upOfficialAt,
    @JsonKey(name: 'last_company') String? lastCompany,
    @JsonKey(name: 'total_posts') int? totalPosts,
    @JsonKey(name: 'total_viewed') int? totalViewed,
    @JsonKey(name: 'total_likes') int? totalLikes,
    @JsonKey(name: 'total_amais') int? totalAmais,
    @JsonKey(name: 'total_points') int? totalPoints,
    @JsonKey(name: 'amai_votes') int? amaiVotes,
    @JsonKey(name: 'created_at') String? createdAt,
    SocialsData? socials,
    EducationData? education,
    BankData? bank,
    IncognitoData? incognito,
    @JsonKey(name: 'work_status') int? workStatus,
    @JsonKey(name: 'work_status_name') String? workStatusName,
    String? department,
    @JsonKey(name: 'have_lunch_menu') bool? haveLunchMenu,
    @JsonKey(name: 'have_internal_announcement') bool? haveInternalAnnouncement,
    @JsonKey(name: 'current_lunch_total_payment') String? currentLunchTotalPayment,
  }) = _ProfileData;

  factory ProfileData.fromJson(Map<String, dynamic> json) => _$ProfileDataFromJson(json);
}
