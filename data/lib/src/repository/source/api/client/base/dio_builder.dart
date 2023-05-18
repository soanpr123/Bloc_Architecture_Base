import 'package:dio/dio.dart';
import 'package:shared/shared.dart';

class DioBuilder {
  const DioBuilder._();

  static Dio createDio({
    BaseOptions? options,
  }) {
    return Dio(
      BaseOptions(
        headers: {'Accept': 'application/json'},
        connectTimeout: options?.connectTimeout ?? const Duration(milliseconds: ServerTimeoutConstants.connectTimeoutInMs),
        receiveTimeout: options?.receiveTimeout ?? const Duration(milliseconds: ServerTimeoutConstants.receiveTimeoutInMs),
        sendTimeout: options?.sendTimeout ?? const Duration(milliseconds: ServerTimeoutConstants.sendTimeoutInMs),
        baseUrl: options?.baseUrl ?? UrlConstants.appApiBaseUrl,
      ),
    );
  }
}
