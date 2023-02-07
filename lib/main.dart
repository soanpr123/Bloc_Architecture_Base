import 'package:flutter/material.dart';
import 'package:project/core/di/dependency_injection.dart';
import 'package:project/core/utils/constants.dart';
import 'package:project/feautures/app/app.dart';

void main() {
  configApp();
  runApp(MyApp());
}

Future<void> configApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.init(DEV_ENVIRONMENT);
}
