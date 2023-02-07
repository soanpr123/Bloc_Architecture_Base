import 'package:get_it/get_it.dart';
import 'package:project/core/config/config_environment.dart';

class ConfigService {
  Future<EnvConfiguration> init(String environment) async {
    final envConfiguration = EnvConfiguration(environment: environment);
    GetIt.instance.registerSingleton(envConfiguration);
    return envConfiguration;
  }
}
