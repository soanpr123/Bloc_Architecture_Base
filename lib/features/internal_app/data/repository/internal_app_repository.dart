import 'dart:io';

import 'package:project/features/internal_app/model/login_model.dart';
import 'package:project/features/internal_app/model/order_menu_model.dart';
import 'package:project/features/internal_app/model/orderd_model.dart';
import 'package:project/features/internal_app/model/profile_model.dart';
import 'package:project/features/internal_app/model/upload_image.dart';
import 'package:retrofit/dio.dart';

abstract class InternalAppRepository {
  // Todo APi request here
  Future<LoginModel> loginRequest(Map<String, dynamic> request);
  Future<HttpResponse> requestForget(Map<String, dynamic> request);
  Future<ProfileModel> requestMe();

  Future<HttpResponse> updateNameMe(Map<String, dynamic> request);
  Future<HttpResponse> updateMe(Map<String, dynamic> request);
  Future<HttpResponse> logOut();
  Future<UploadImage> uploadImage(File file, String type);
  Future<HttpResponse> changePass(Map<String, dynamic> request);
  Future<OrderMenu> requestOrderMenu();
  Future<HttpResponse> orderStore(Map<String,dynamic> id);

  Future<OrderedModel> ordered();

  Future<HttpResponse> updateStore(int id);

  Future<HttpResponse> deleteStore();
}
