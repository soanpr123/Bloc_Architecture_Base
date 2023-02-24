import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_upload.freezed.dart';

@freezed
class ImageUpload with _$ImageUpload {
  const factory ImageUpload({
    @Default('') String url,
    @Default('') String thumb,
    @Default('') String type,
    @Default('') String message,
    @Default(200) int statusCode,
  }) = _ImageUpload;
}
