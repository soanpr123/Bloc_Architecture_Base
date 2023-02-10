// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadImage _$UploadImageFromJson(Map<String, dynamic> json) => UploadImage(
      status_code: json['status_code'] as int?,
      message: json['message'] as String?,
      errors: json['errors'] as String?,
      data: json['data'] == null
          ? null
          : DataUpload.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UploadImageToJson(UploadImage instance) =>
    <String, dynamic>{
      'status_code': instance.status_code,
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };

DataUpload _$DataUploadFromJson(Map<String, dynamic> json) => DataUpload(
      url: json['url'] as String?,
      thumb: json['thumb'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$DataUploadToJson(DataUpload instance) =>
    <String, dynamic>{
      'url': instance.url,
      'thumb': instance.thumb,
      'type': instance.type,
    };
