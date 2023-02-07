import 'package:project/core/config/Configuration.Debug.dart';
import 'package:project/core/config/Configuration.PROD.dart';
import 'package:project/core/utils/constants.dart';

class EnvConfiguration {
  final String environment;
  Map<String, String> value = <String, String>{};

  EnvConfiguration({required this.environment}) {
    getValue(environment);
  }

  void getValue(String? environment) {
    switch (environment) {
      case DEV_ENVIRONMENT:
        value = debugAppSettings;
        return;
      case PROD_ENVIRONMENT:
        value = productsAppSettings;
        return;
      default:
        value = debugAppSettings;
        return;
    }
  }
}
