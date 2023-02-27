import 'package:freezed_annotation/freezed_annotation.dart';
part 'announcement_detail_data.freezed.dart';
part 'announcement_detail_data.g.dart';

@freezed
class AnnouncementDetailData with _$AnnouncementDetailData {
  const factory AnnouncementDetailData({
    String? title,
    String? slug,
    String? content,
    String? thumb,
    String? url,
    @JsonKey(name: "created_at") String? createdAt,
    @JsonKey(name: "updated_at") String? updatedAt,
  }) = _AnnouncementDetailData;

  factory AnnouncementDetailData.fromJson(Map<String, dynamic> json) => _$AnnouncementDetailDataFromJson(json);
}


