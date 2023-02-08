import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'login_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable(
  explicitToJson: false,
)
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

  factory LoginModel.fromJson(Map<String, dynamic> json) => _$LoginModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}

@JsonSerializable(
  explicitToJson: false,
)
@HiveType(typeId: 1)
class Data {
  @HiveField(0)
  String? access_token;
  @HiveField(1)
  String? typeToken;

  Data({this.access_token, this.typeToken});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}
