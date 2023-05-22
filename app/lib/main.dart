import 'dart:async';

import 'package:app/config/firebase_message_config.dart';
import 'package:app/firebase_options.dart';
import 'package:domain/domain.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:initializer/initializer.dart';
import 'package:shared/shared.dart';

import 'app/my_app.dart';
import 'config/app_config.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await FirebaseMessageConfig().initFirebaseMessageConfig();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await Fireb
  FirebaseMessaging.onBackgroundMessage(
    _firebaseMessagingBackgroundHandler,
  );

  await AppInitializer(AppConfig.getInstance()).init();
  await runZonedGuarded(_runMyApp, _reportError);
}

Future<LoadInitialResourceOutput> _loadInitialResource() async {
  final result = runCatching(
    action: () => GetIt.instance.get<LoadInitialResourceUseCase>().execute(const LoadInitialResourceInput()),
  );

  return result.when(
    success: (output) => output,
    failure: (e) => const LoadInitialResourceOutput(),
  );
}

Future<void> _runMyApp() async {
  final initialResource = await _loadInitialResource();
  runApp(MyApp(
    initialResource: initialResource,
  ));
}

void _reportError(Object error, StackTrace stackTrace) {
  Log.e(error, stackTrace: stackTrace, name: 'Uncaught exception');

  // report by Firebase Crashlytics here
}
