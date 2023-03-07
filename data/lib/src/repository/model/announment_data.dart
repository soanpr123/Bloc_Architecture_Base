import 'package:freezed_annotation/freezed_annotation.dart';
part 'announment_data.freezed.dart';
part 'announment_data.g.dart';

@freezed
class Data2Announment with _$Data2Announment {
  const factory Data2Announment({
    String? title,
    String? slug,
    @JsonKey(name: 'is_read') int? isRead,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _Data2Announment;

  factory Data2Announment.fromJson(Map<String, dynamic> json) => _$Data2AnnounmentFromJson(json);
}

@freezed
class AnnounmentData with _$AnnounmentData {
  const factory AnnounmentData({
    List<Data2Announment>? data,
    @JsonKey(name: 'per_page') int? perPage,
    @JsonKey(name: 'total_page') int? totalPage,
    @JsonKey(name: 'current_page') int? currentPage,
    int? total,
  }) = _AnnounmentData;

  factory AnnounmentData.fromJson(Map<String, dynamic> json) => _$AnnounmentDataFromJson(json);
}
