
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:get_it/get_it.dart';
import 'package:initializer/initializer.dart';
import 'package:shared/shared.dart';

import '../app.dart';
import '../di/di.dart' as di;

class AppConfig extends ApplicationConfig {
  factory AppConfig.getInstance() {
    return _instance;
  }

  AppConfig._();

  static final AppConfig _instance = AppConfig._();

  @override
  Future<void> config() async {
    await di.configureInjection();
    di.getIt.registerSingleton<AppRouter>(AppRouter());
    Bloc.observer = AppBlocObserver();
    await ViewUtils.setPreferredOrientations(
      DeviceUtils.deviceType == DeviceType.mobile ? UiConstants.mobileOrientation : UiConstants.tabletOrientation,
    );
    ViewUtils.setsetEnabledSystemUIOverlays(SystemUiMode.immersiveSticky);

    // await LocalPushNotificationHelper.init();
  }
}
