import 'dart:io';

import 'package:dio/dio.dart';
import 'package:project/features/internal_app/model/amai_history.dart';
import 'package:project/features/internal_app/model/announcement_detail_model.dart';
import 'package:project/features/internal_app/model/announcement_model.dart';
import 'package:project/features/internal_app/model/login_model.dart';
import 'package:project/features/internal_app/model/notification_model.dart';
import 'package:project/features/internal_app/model/order_menu_model.dart';
import 'package:project/features/internal_app/model/orderd_model.dart';
import 'package:project/features/internal_app/model/profile_model.dart';
import 'package:project/features/internal_app/model/upload_image.dart';
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

  @POST("auth/change-password")
  Future<HttpResponse> changePass(@Body() Map<String, dynamic> request);

  @POST("upload-image")
  Future<UploadImage> uploadImage(@Part(name: "image") File file, @Part(name: "type") String type);

  @POST("auth/logout")
  Future<HttpResponse> logOut();

  // API Store //

  @GET("order-lunch/menu")
  Future<OrderMenu> requestOrderMenu();

  // API Announcement//
  @GET("announcements?orders[0][key]=updated_at&orders[0][dir]=asc&page={page}&per_page={per_page}")
  Future<AnnouncementModel> requestAnnouncement(@Path("page") int page, @Path("per_page") int perPage);

  @POST("order-lunch")
  Future<HttpResponse> orderStore(@Body() Map<String, dynamic> id);

  @GET("order-lunch/ordered")
  Future<OrderedModel> ordered();

  @POST("order-lunch/update")
  Future<HttpResponse> updateStore(@Body() int id);

  @POST("order-lunch/delete")
  Future<HttpResponse> deleteStore();

  @GET("announcements/{slug}")
  Future<AnnouncementDetail> requestReadAnnouncement(@Path("slug") String slugs);

  @POST("announcements/{slug}/read-link")
  Future<HttpResponse> checkUsertReadAnnouncement(@Path("slug") String slugs);

  @GET("notifications/unread/total")
  Future<HttpResponse> getTotalUnread();

  @GET("notifications/?page={page}&per_page={perPage}")
  Future<NotificationModel> requestNotification(@Path("page") int page, @Path("perPage") int perPage);

  @GET("notifications/unread/?page={page}&per_page={perPage}")
  Future<NotificationModel> requestNotificationUnread(@Path("page") int page, @Path("perPage") int perPage);

  @GET("notifications/{id}")
  Future<HttpResponse> showNotification(@Path("id") String id);

  @POST("transactions")
  Future<HttpResponse> paymentAmai(@Body() Map<String, dynamic> request);

  @GET("transactions/histories?page={page}&per_page={perPage}")
  Future<AmaiHistory> amaiHistory(@Path("page") int page, @Path("perPage") int perPage);
}
