import 'package:dio/dio.dart';
import 'package:project/core/sevices/globals.dart' as globals;

class AuthInterceptor extends Interceptor {
  AuthInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final headers = options.headers;

    final accessToken = globals.accessToken;
    if (accessToken.isNotEmpty) {
      headers.putIfAbsent('Authorization', () => 'Bearer $accessToken');
    }

    // headers.putIfAbsent('deviceOS', () => AppDataGlobal.deviceOS);
    // headers.putIfAbsent('osVersion', () => AppDataGlobal.osVersion);
    // headers.putIfAbsent('appVersion', () => AppDataGlobal.appVersion);
    handler.next(options);
  }
  // @override
  // Future onRequest(RequestOptions options) async {
  //   options.headers['Content-Type'] = 'application/json';
  //   options.headers['Client-Key'] = _clientKey;
  //   options.headers['Authorization'] = 'Bearer BEARER_TOKEN1';

  //   final session = SessionPref.getAccessToken();
  //   if (session != null) {
  //     options.headers[ACCESS_TOKEN] = 'Bearer $session';
  //   }
  //   return super.onRequest(options);
  // }
}
