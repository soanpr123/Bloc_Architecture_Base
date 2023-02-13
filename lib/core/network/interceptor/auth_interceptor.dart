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

    handler.next(options);
  }
}
