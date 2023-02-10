import 'dart:io';

import 'package:project/feautures/internal_app/data/data_source/remote/internal_app_remote.dart';
import 'package:project/feautures/internal_app/data/repository/internal_app_repository.dart';
import 'package:project/feautures/internal_app/model/login_model.dart';
import 'package:project/feautures/internal_app/model/profile_model.dart';
import 'package:project/feautures/internal_app/model/upload_image.dart';
import 'package:retrofit/dio.dart';

class InternalAppRepositoryImpl extends InternalAppRepository {
  final INTERNALAPPAPI _api;
  InternalAppRepositoryImpl(this._api);

  @override
  Future<LoginModel> loginRequest(Map<String, dynamic> request) {
    return _api.loginRequest(request);
  }

  @override
  Future<HttpResponse> requestForget(Map<String, dynamic> request) {
    return _api.requestForget(request);
  }

  @override
  Future<ProfileModel> requestMe() {
    return _api.requestMe();
  }

  @override
  Future<HttpResponse> updateNameMe(Map<String, dynamic> request) {
    return _api.updateMeName(request);
  }

  @override
  Future<HttpResponse> updateMe(Map<String, dynamic> request) {
    return _api.updateMe(request);
  }

  @override
  Future<HttpResponse> logOut() {
    return _api.logOut();
  }

  @override
  Future<UploadImage> uploadImage(File file, String type) {
    return _api.uploadImage(file, type);
  }
}
