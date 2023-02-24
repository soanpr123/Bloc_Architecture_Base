import 'dart:io';

import 'package:dio/dio.dart';

import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../../../data.dart';
import '../../model/amai_order_data.dart';
import '../../model/amai_store_data.dart';
import '../../model/history_amai_data.dart';
import '../../model/profile_data.dart';
import '../../model/upload_image_data.dart';

@LazySingleton()
class AppApiService {
  AppApiService(
    this._noneAuthAppServerApiClient,
    this._authAppServerApiClient,
    this._randomUserApiClient,
  );

  final NoneAuthAppServerApiClient _noneAuthAppServerApiClient;
  final AuthAppServerApiClient _authAppServerApiClient;
  final RandomUserApiClient _randomUserApiClient;

  Future<DataResponse<TokenData>> login(String email, String password) async {
    return _noneAuthAppServerApiClient.request(
      method: RestMethod.post,
      path: 'auth/login',
      body: {
        'email': email,
        'password': password,
      },
      decoder: TokenData.fromJson,
    );
  }

  Future<DataResponse<dynamic>> logout() async {
    return await _authAppServerApiClient.request(
      method: RestMethod.post,
      path: 'auth/logout',
    );
  }

  Future<DataResponse<AuthResponseData>> register({
    required String username,
    required String email,
    required String password,
    required int gender,
  }) async {
    return _authAppServerApiClient.request(
      method: RestMethod.post,
      path: '/v1/auth/register',
      body: {
        'username': username,
        'gender': gender,
        'email': email,
        'password': password,
        'password_confirmation': password,
      },
      decoder: AuthResponseData.fromJson,
    );
  }

  Future<DataResponse<dynamic>> forgotPassword(String email) async {
    return await _noneAuthAppServerApiClient.request(
      method: RestMethod.post,
      path: 'forgot-password',
      body: {
        'email': email,
      },
    );
  }

  Future<DataResponse<dynamic>> updateMe(String avt, String about) async {
    return await _authAppServerApiClient.request(
      method: RestMethod.post,
      path: 'auth/me',
      body: {
        'avatar': avt,
        'about': about,
      },
    );
  }

  Future<DataResponse<ImageUploadData>> uploadImage(File avt, String type) async {
    final fileName = avt.path.split('/').last;
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(avt.path, filename: fileName),
      'type': type,
    });

    return await _authAppServerApiClient.request(
      method: RestMethod.post,
      path: 'upload-image',
      body: formData,
      decoder: ImageUploadData.fromJson,
    );
  }

  Future<DataResponse<dynamic>> updateMename(
    String name,
  ) async {
    return await _authAppServerApiClient.request(
      method: RestMethod.post,
      path: 'auth/me/name',
      body: {
        'name': name,
      },
    );
  }

  Future<void> resetPassword({
    required String token,
    required String email,
    required String password,
  }) async {
    await _noneAuthAppServerApiClient.request(
      method: RestMethod.post,
      path: '/v1/auth/reset-password',
      body: {
        'token': token,
        'email': email,
        'password': password,
        'password_confirmation': password,
      },
    );
  }

  Future<DataResponse<ProfileData>> getMe() async {
    return _authAppServerApiClient.request(
      method: RestMethod.get,
      path: 'auth/me',
      decoder: ProfileData.fromJson,
    );
  }

  Future<ResultsListResponse<UserData>> getUsers({
    required int page,
    required int? limit,
  }) {
    return _randomUserApiClient.request(
      method: RestMethod.get,
      path: '',
      queryParameters: {
        'page': page,
        'results': limit,
      },
      successResponseMapperType: SuccessResponseMapperType.resultsJsonArray,
      decoder: UserData.fromJson,
    );
  }

  Future<DataResponse<NotificationData>> getNotification({
    required int page,
    required int? limit,
  }) {
    return _authAppServerApiClient.request(
      method: RestMethod.get,
      path: 'notifications',
      queryParameters: {
        'page': page,
        'per_page': limit,
      },
      // successResponseMapperType: SuccessResponseMapperType.jsonArray,
      decoder: NotificationData.fromJson,
    );
  }

  Future<DataResponse<NotificationData>> getNotificationUnread({
    required int page,
    required int? limit,
  }) {
    return _authAppServerApiClient.request(
      method: RestMethod.get,
      path: 'notifications/unread',
      queryParameters: {
        'page': page,
        'per_page': limit,
      },
      // successResponseMapperType: SuccessResponseMapperType.jsonArray,
      decoder: NotificationData.fromJson,
    );
  }

  Future<DataResponse<HistoryAmaiData>> getHistoryData({
    required int page,
    required int? limit,
  }) {
    return _authAppServerApiClient.request(
      method: RestMethod.get,
      path: 'transactions/histories',
      queryParameters: {
        'page': page,
        'per_page': limit,
      },
      // successResponseMapperType: SuccessResponseMapperType.jsonArray,
      decoder: HistoryAmaiData.fromJson,
    );
  }

  Future<DataResponse<dynamic>> readNotifi(String id) async {
    return await _authAppServerApiClient.request(
      method: RestMethod.get,
      path: 'notifications/$id',
    );
  }

  Future<DataResponse<dynamic>> getTotalNoti() async {
    return await _authAppServerApiClient.request(
      method: RestMethod.get,
      path: 'notifications/unread/total',
    );
  }

  Future<DataResponse<dynamic>> payment(int amai, String note) async {
    return await _authAppServerApiClient.request(method: RestMethod.post, path: 'transactions', body: {
      'amount_amais': amai,
      'note': note,
    });
  }

  Future<DataResponse<AmaiStoreData>> getDataStore() async {
    return await _authAppServerApiClient.request(
        method: RestMethod.get, path: 'order-lunch/menu', decoder: AmaiStoreData.fromJson);
  }

  Future<DataResponse<AmaiOrderData>> getOrderStore() async {
    return await _authAppServerApiClient.request(
      method: RestMethod.get,
      path: 'order-lunch/ordered',
      decoder: AmaiOrderData.fromJson,
    );
  }

  Future<DataResponse<dynamic>> orderStore(String id) async {
    return await _authAppServerApiClient.request(
      method: RestMethod.post,
      path: 'order-lunch',
      body: {
        'lunch_menus_id': id,
      },
    );
  }

  Future<DataResponse<dynamic>> deleteOrderStore() async {
    return await _authAppServerApiClient.request(
      method: RestMethod.post,
      path: 'order-lunch/delete',
    );
  }
}