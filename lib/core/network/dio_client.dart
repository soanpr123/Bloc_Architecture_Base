import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';

class DioClient {
  static late Dio _dio;
  static Future<Dio> setup({required String baseUrl}) async {
    final options = BaseOptions(
      responseType: ResponseType.json,
      // contentType: "application/x-www-form-urlencoded",
      validateStatus: (status) {
        return true;
      },
      baseUrl: baseUrl,
      receiveTimeout: 30000, // 30s
      sendTimeout: 30000, // 30s
    );
    _dio = Dio(options);

    // _dio.interceptors.add(AuthInterceptor());

    _dio.interceptors.add(
      AwesomeDioInterceptor(),
    );

    return _dio;
  }

  static Dio get dio => _dio;
}
