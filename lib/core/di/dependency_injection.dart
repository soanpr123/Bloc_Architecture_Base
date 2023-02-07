import 'package:get_it/get_it.dart';
import 'package:project/core/network/dio_client.dart';
import 'package:project/core/sevices/config_service.dart';
import 'package:project/core/utils/constants.dart';
import 'package:project/feautures/internal_app/data/data_source/remote/internal_app_remote.dart';
import 'package:project/feautures/internal_app/data/repository/internal_app_repository.dart';
import 'package:project/feautures/internal_app/data/repository/internal_app_repository_Impl.dart';

final getIt = GetIt.instance;

class DependencyInjection {
  static Future init(String environment) async {
    final config = await ConfigService().init(environment);
    final dioUIAPI = await DioClient.setup(baseUrl: config.value[UIAPI] ?? '');
    final internalAppApi = INTERNALAPPAPI(dioUIAPI);
    // final InternalAppRepository apiRepo =
    // InternalAppRepositoryImpl(internalAppApi);
    getIt.registerLazySingleton<InternalAppRepository>(
        () => InternalAppRepositoryImpl(internalAppApi));
  }
}
