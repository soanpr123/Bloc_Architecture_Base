import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:project/core/network/interceptor/api_exception.dart';
import 'package:project/core/network/interceptor/auth_interceptor.dart';

class DioClient {
  static late Dio _dio;
  final tokenBox = GetIt.I<Box<String>>();
  static Future<Dio> setup({required String baseUrl}) async {
    final options = BaseOptions(
      responseType: ResponseType.json,
      contentType: "application/json",
      headers: {"Accept": "application/json"},
      validateStatus: (status) {
        return true;
      },
      baseUrl: baseUrl,
      receiveTimeout: 30000, // 30s
      sendTimeout: 30000, // 30s
    );
    _dio = Dio(options);

    _dio.interceptors.add(AuthInterceptor());
    _dio.interceptors.add(ExceptionAuth());
    _dio.interceptors.add(
      AwesomeDioInterceptor(),
    );

    return _dio;
  }

  static Dio get dio => _dio;
}
