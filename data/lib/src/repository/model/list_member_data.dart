import 'package:freezed_annotation/freezed_annotation.dart';
part 'list_member_data.freezed.dart';
part 'list_member_data.g.dart';

@freezed
class Data2ListMemberData with _$Data2ListMemberData {
  const factory Data2ListMemberData({
    int? id,
    String? name,
    String? email,
    String? gender,
    String? dob,
    String? about,
    String? avatar,
    @JsonKey(name: 'facebook_username') String? facebookUsername,
    @JsonKey(name: 'telegram_username') String? telegramUsername,
    String? position,
    String? department,
  }) = _Data2ListMemberData;

  factory Data2ListMemberData.fromJson(Map<String, dynamic> json) => _$Data2ListMemberDataFromJson(json);
}

@freezed
class ListMemberData with _$ListMemberData {
  const factory ListMemberData({
    List<Data2ListMemberData>? data,
    @JsonKey(name: 'per_page') int? perPage,
    @JsonKey(name: 'total_page') int? totalPage,
    @JsonKey(name: 'current_page') int? currentPage,
    int? total,
  }) = _ListMemberData;

  factory ListMemberData.fromJson(Map<String, dynamic> json) => _$ListMemberDataFromJson(json);
}

