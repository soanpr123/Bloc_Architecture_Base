import 'package:freezed_annotation/freezed_annotation.dart';

part 'announcement_detail.freezed.dart';

@freezed
class AnnouncementDetail with _$AnnouncementDetail {
  const factory AnnouncementDetail({
    @Default('') String? title,
    @Default('') String? slug,
    @Default('') String? content,
    @Default('') String? thumb,
    @Default('') String? url,
    @Default('') String? createdAt,
    @Default('') String? updatedAt,
  }) = _AnnouncementDetail;
}
