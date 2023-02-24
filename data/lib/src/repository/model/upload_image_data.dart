import 'package:freezed_annotation/freezed_annotation.dart';
part 'upload_image_data.freezed.dart';
part 'upload_image_data.g.dart';

@freezed
class ImageUploadData with _$ImageUploadData {
  const factory ImageUploadData({
    String? url,
    String? thumb,
    String? type,
  }) = _ImageUploadData;

  factory ImageUploadData.fromJson(Map<String, dynamic> json) => _$ImageUploadDataFromJson(json);
}
