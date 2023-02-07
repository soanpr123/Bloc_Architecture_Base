import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project/core/di/dependency_injection.dart';
import 'package:project/core/utils/constants.dart';
import 'package:project/feautures/app/app.dart';
import 'package:project/feautures/internal_app/model/login_model.dart';

void main() async {
  await configApp();
  runApp(MyApp());
}

Future<void> configApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();

  Hive.init(appDocumentDirectory.path);

  await DependencyInjection.init(DEV_ENVIRONMENT);
}
