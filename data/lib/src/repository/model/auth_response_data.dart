import 'package:freezed_annotation/freezed_annotation.dart';
part 'auth_response_data.freezed.dart';
part 'auth_response_data.g.dart';

@freezed
class Data with _$Data {
  const factory Data({
    @JsonKey(name: 'access_token') String? accessToken,
    @JsonKey(name: 'type_token') String? typeToken,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
class AuthResponseData with _$AuthResponseData {
  const factory AuthResponseData({
    @JsonKey(name: 'status_code') int? statusCode,
    String? message,
    dynamic errors,
    Data? data,
  }) = _AuthResponseData;

  factory AuthResponseData.fromJson(Map<String, dynamic> json) => _$AuthResponseDataFromJson(json);
}
