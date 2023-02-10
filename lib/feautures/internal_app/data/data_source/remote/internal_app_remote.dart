import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/feautures/internal_app/model/login_model.dart';
import 'package:project/feautures/internal_app/model/profile_model.dart';
import 'package:project/feautures/internal_app/model/upload_image.dart';
import 'package:retrofit/retrofit.dart';

part 'internal_app_remote.g.dart';

@RestApi()
abstract class INTERNALAPPAPI {
  factory INTERNALAPPAPI(Dio dio, {String baseUrl}) = _INTERNALAPPAPI;
  // Todo APi request here
  // API AUTH //
  @POST("auth/login")
  Future<LoginModel> loginRequest(@Body() Map<String, dynamic> request);

  @POST("forgot-password")
  Future<HttpResponse> requestForget(@Body() Map<String, dynamic> request);

  @GET("auth/me")
  Future<ProfileModel> requestMe();

  @POST("auth/me/name")
  Future<HttpResponse> updateMeName(@Body() Map<String, dynamic> request);

  @POST("auth/me")
  Future<HttpResponse> updateMe(@Body() Map<String, dynamic> request);

  @POST("upload-image")
  Future<UploadImage> uploadImage(@Part(name: "image") File file, @Part(name: "type") String type);

  @POST("auth/logout")
  Future<HttpResponse> logOut();
}
