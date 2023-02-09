import 'package:project/feautures/internal_app/data/data_source/remote/internal_app_remote.dart';
import 'package:project/feautures/internal_app/data/repository/internal_app_repository.dart';
import 'package:project/feautures/internal_app/model/login_model.dart';
import 'package:retrofit/dio.dart';

class InternalAppRepositoryImpl extends InternalAppRepository {
  final INTERNALAPPAPI _api;
  InternalAppRepositoryImpl(this._api);

  @override
  Future<LoginModel> loginRequest(Map<String, dynamic> request) {
    // TODO: implement loginRequest
    return _api.loginRequest(request);
  }

  @override
  Future<HttpResponse> requestForget(Map<String, dynamic> request) {
    // TODO: implement requestForget
    return _api.requestForget(request);
  }
}
