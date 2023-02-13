import 'dart:io';

import 'package:project/features/internal_app/data/data_source/remote/internal_app_remote.dart';
import 'package:project/features/internal_app/data/repository/internal_app_repository.dart';
import 'package:project/features/internal_app/model/login_model.dart';
import 'package:project/features/internal_app/model/order_menu_model.dart';
import 'package:project/features/internal_app/model/orderd_model.dart';
import 'package:project/features/internal_app/model/profile_model.dart';
import 'package:project/features/internal_app/model/upload_image.dart';
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

  @override
  Future<HttpResponse> changePass(Map<String, dynamic> request) {
    return _api.changePass(request);
  }

  @override
  Future<OrderMenu> requestOrderMenu() {
    return _api.requestOrderMenu();
  }

  @override
  Future<HttpResponse> deleteStore() {
    return _api.deleteStore();
  }

  @override
  Future<HttpResponse> orderStore(Map<String, dynamic> id) {
    return _api.orderStore(id);
  }

  @override
  Future<OrderedModel> ordered() {
    return _api.ordered();
  }

  @override
  Future<HttpResponse> updateStore(int id) {
    return _api.updateStore(id);
  }
}
