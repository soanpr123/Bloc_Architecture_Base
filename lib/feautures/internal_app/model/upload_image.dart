import 'package:json_annotation/json_annotation.dart';
part 'upload_image.g.dart';

@JsonSerializable()
class UploadImage {
  int? status_code;
  String? message;
  String? errors;
  DataUpload? data;

  UploadImage({this.status_code, this.message, this.errors, this.data});

  factory UploadImage.fromJson(Map<String, dynamic> json) => _$UploadImageFromJson(json);
  Map<String, dynamic> toJson() => _$UploadImageToJson(this);
}

@JsonSerializable()
class DataUpload {
  String? url;
  String? thumb;
  String? type;

  DataUpload({this.url, this.thumb, this.type});

  factory DataUpload.fromJson(Map<String, dynamic> json) => _$DataUploadFromJson(json);
  Map<String, dynamic> toJson() => _$DataUploadToJson(this);
}
