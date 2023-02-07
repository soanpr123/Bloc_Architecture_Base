import 'package:dio/dio.dart';
import 'package:project/feautures/internal_app/model/login_model.dart';
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
}
