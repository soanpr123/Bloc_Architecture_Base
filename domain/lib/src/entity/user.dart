import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain.dart';

part 'user.freezed.dart';

@freezed
class Profile with _$Profile {
  const factory Profile({
    @Default(0) int? id,
    @Default(0) int? positionId,
    @Default('') String? positionName,
    @Default('') String? name,
    @Default('') String? email,
    @Default('') String? phone,
    @Default('') String? personalEmail,
    @Default(0) int? genderId,
    @Default('') String? gender,
    @Default('') String? dob,
    @Default('') String? avatar,
    @Default('') String? address,
    @Default('') dynamic about,
    @Default('') String? citizenId,
    @Default('') String? lastOnlineAt,
    @Default('') String? joinCompanyAt,
    @Default('') String? upOfficialAt,
    @Default('') String? lastCompany,
    @Default(0) int? totalPosts,
    @Default(0) int? totalViewed,
    @Default(0) int? totalLikes,
    @Default(0) int? totalAmais,
    @Default(0) int? totalPoints,
    @Default(0) int? amaiVotes,
    @Default('') String? createdAt,
    @Default(Socials()) Socials? socials,
    @Default(Bank()) Bank? bank,
    @Default(Incognito()) Incognito? incognito,
    @Default(Educate()) Educate? education,
    @Default(0) int? workStatus,
    @Default('') String? workStatusName,
    @Default('') String? department,
    @Default(false) bool? haveLunchMenu,
  }) = _Profile;
}
