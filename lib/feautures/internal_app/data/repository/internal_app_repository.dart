import 'package:project/feautures/internal_app/model/login_model.dart';
import 'package:retrofit/dio.dart';

abstract class InternalAppRepository {
  // Todo APi request here
  Future<LoginModel> loginRequest(Map<String, dynamic> request);
  Future<HttpResponse> requestForget(Map<String, dynamic> request);
}
