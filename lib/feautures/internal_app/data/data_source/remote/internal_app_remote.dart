import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'internal_app_remote.g.dart';

@RestApi()
abstract class INTERNALAPPAPI {
  factory INTERNALAPPAPI(Dio dio, {String baseUrl}) = _INTERNALAPPAPI;
  // Todo APi request here
}
