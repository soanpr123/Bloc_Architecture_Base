import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:project/core/network/dio_client.dart';
import 'package:project/core/sevices/config_service.dart';
import 'package:project/core/utils/constants.dart';
import 'package:project/features/internal_app/data/data_source/remote/internal_app_remote.dart';
import 'package:project/features/internal_app/data/repository/internal_app_repository.dart';
import 'package:project/features/internal_app/data/repository/internal_app_repository_Impl.dart';
import 'package:project/features/internal_app/model/login_model.dart';
import 'package:project/features/profile_page/cubit/profile_cubit.dart';
// import 'package:project/features/splash_page/cubit/spalsh_cubit.dart';

final getIt = GetIt.instance;

// final
class DependencyInjection {
  static Future init(String environment) async {
    final config = await ConfigService().init(environment);

    final userBox = await Hive.openBox('users');
    final appbox = await Hive.openBox<String>('appBox');
    getIt.registerSingleton(userBox);
    getIt.registerSingleton(appbox);
    Hive.registerAdapter<LoginModel>(LoginModelAdapter());
    final dioUIAPI = await DioClient.setup(baseUrl: config.value[UIAPI] ?? '');
    final internalAppApi = INTERNALAPPAPI(dioUIAPI);
    // final InternalAppRepository apiRepo =
    // InternalAppRepositoryImpl(internalAppApi);

    getIt.registerLazySingleton<InternalAppRepository>(() => InternalAppRepositoryImpl(internalAppApi));
    getIt.registerSingleton(ProfileCubit());
  }
}
