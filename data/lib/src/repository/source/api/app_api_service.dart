import 'dart:io';

import 'package:dio/dio.dart';

import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../../../data.dart';
import '../../model/amai_order_data.dart';
import '../../model/amai_store_data.dart';
import '../../model/announcement_detail_data.dart';
import '../../model/blogs_model_data.dart';
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

  Future<DataResponse<dynamic>> resetPassword({
    required String pass,
    required String newpass,
    required String password,
  }) async {
    return await _authAppServerApiClient.request(
      method: RestMethod.post,
      path: 'auth/change-password',
      body: {
        'current_password': pass,
        'password': newpass,
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

  Future<DataResponse<ListMemberData>> getMember({
    required int page,
    required int? limit,
  }) {
    return _authAppServerApiClient.request(
      method: RestMethod.get,
      path: 'staffs',
      queryParameters: {
        'page': page,
        'per_page': limit,
      },
      // successResponseMapperType: SuccessResponseMapperType.jsonArray,
      decoder: ListMemberData.fromJson,
    );
  }

  Future<DataResponse<dynamic>> checkUserRead({required String slungs}) {
    return _authAppServerApiClient.request(
      method: RestMethod.post,
      path: 'announcements/$slungs/read-link',
    );
  }

  Future<DataResponse<dynamic>> likeBlogs({required String slungs}) {
    return _authAppServerApiClient.request(
      method: RestMethod.post,
      path: 'posts/$slungs/like',
    );
  }

  Future<DataResponse<dynamic>> likeComment({required String slungs, required int id}) {
    return _authAppServerApiClient.request(
      method: RestMethod.post,
      path: 'posts/$slungs/$id/like',
    );
  }

  Future<DataResponse<dynamic>> sendAmai({required String slungs}) {
    return _authAppServerApiClient.request(
      method: RestMethod.post,
      path: 'posts/$slungs/amai',
    );
  }

  Future<DataResponse<WikiModelData>> getListWiki({
    required int page,
    required int? limit,
  }) {
    return _authAppServerApiClient.request(
      method: RestMethod.get,
      path: 'wiki',
      queryParameters: {
        'page': page,
        'per_page': limit,
        'orders[0][key]': 'created_at',
        'orders[0][dir]': 'desc',
      },
      decoder: WikiModelData.fromJson,
    );
  }

  Future<DataResponse<WikiDetailData>> getDetailWiki({required String slungs}) {
    return _authAppServerApiClient.request(
      method: RestMethod.get,
      path: 'wiki/$slungs',
      decoder: WikiDetailData.fromJson,
    );
  }

  Future<DataResponse<BlogsModelData>> getDetailBlogs({required String slungs}) {
    return _authAppServerApiClient.request(
      method: RestMethod.get,
      path: 'posts/$slungs',
      decoder: BlogsModelData.fromJson,
    );
  }

  Future<DataResponse<AnnounmentData>> getAnnounment({
    required int page,
    required int? limit,
  }) {
    return _authAppServerApiClient.request(
      method: RestMethod.get,
      path: 'announcements',
      queryParameters: {
        'page': page,
        'per_page': limit,
        'orders[0][key]': 'updated_at',
        'orders[0][dir]': 'asc',
      },
      // successResponseMapperType: SuccessResponseMapperType.jsonArray,
      decoder: AnnounmentData.fromJson,
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

  Future<DataListResponse<Data2HistoryAmai>> getHistoryData({
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
      successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
      decoder: Data2HistoryAmai.fromJson,
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

  Future<DataResponse<dynamic>> readAll() async {
    return await _authAppServerApiClient.request(
      method: RestMethod.post,
      path: 'notifications/all-read',
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

  Future<DataResponse<AnnouncementDetailData>> getAnnouncementDetail(String slungs) async {
    return await _authAppServerApiClient.request(
      method: RestMethod.get,
      path: 'announcements/$slungs',
      decoder: AnnouncementDetailData.fromJson,
    );
  }

  Future<DataListResponse<ComentDataModel>> getComent(String slungs) async {
    return await _authAppServerApiClient.request(
      method: RestMethod.get,
      path: 'posts/$slungs/comments',
      successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
      decoder: ComentDataModel.fromJson,
    );
  }
}
