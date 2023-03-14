import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_data_entry.freezed.dart';

@freezed
class MemberDataEntry with _$MemberDataEntry {
  const factory MemberDataEntry({
    @Default(-1) int? id,
    @Default('') String? name,
    @Default('') String? email,
    @Default('') String? gender,
    @Default('') String? dob,
    @Default('') String? about,
    @Default('') String? avatar,
    @Default('') String? facebookUsername,
    @Default('') String? telegramUsername,
    @Default('') String? position,
    @Default('') String? department,
  }) = _MemberDataEntry;
}
