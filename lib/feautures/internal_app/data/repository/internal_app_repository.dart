import 'package:project/feautures/internal_app/model/login_model.dart';

abstract class InternalAppRepository {
  // Todo APi request here
  Future<LoginModel> loginRequest(Map<String, dynamic> request);
}
