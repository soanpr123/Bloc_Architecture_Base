import 'package:hive/hive.dart';
// import 'package:json_annotation/json_annotation.dart';
part 'login_model.g.dart';

@HiveType(typeId: 0)
class LoginModel {
  @HiveField(0)
  int? statusCode;
  @HiveField(1)
  String? message;
  @HiveField(2)
  String? errors;
  @HiveField(3)
  Data? data;

  LoginModel({this.statusCode, this.message, this.errors, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    errors = json['errors'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = statusCode;
    data['message'] = message;
    data['errors'] = errors;

    data['data'] = data;

    return data;
  }
}

@HiveType(typeId: 1)
class Data {
  @HiveField(0)
  String? accessToken;
  @HiveField(1)
  String? typeToken;

  Data({this.accessToken, this.typeToken});
  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    typeToken = json['type_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['type_token'] = typeToken;
    return data;
  }
}
