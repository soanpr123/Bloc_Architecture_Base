import 'dart:io';

import 'package:dio/dio.dart';

import 'package:project/core/routers/router.dart';
import 'package:project/core/sevices/user_service.dart';
// import 'package:project/core/routers/router.gr.dart';
import 'package:project/core/utils/toast_message.dart';

class ExceptionAuth extends InterceptorsWrapper {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == HttpStatus.notFound) {
      // 404 NOT FOUND//
    } else if (err.response?.statusCode == HttpStatus.unauthorized) {
      //UNAUTHORIZED//
      // Routers().replace(LoginRoute());
      UserService.instance.setCurrentToken("");
      AppRouter().replace(LoginRoute());
    } else {
      errorToast(msg: "Lỗi kết nối");
    }
  }
}
