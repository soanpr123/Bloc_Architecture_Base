import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:project/core/routers/router.gr.dart';
import 'package:project/core/sevices/user_service.dart';
import 'package:project/core/style/resource.dart';
import 'package:project/core/utils/constants.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final tokenBox = GetIt.I<Box<String>>();
  @override
  void initState() {
    super.initState();
    loadShowApp();
  }

  Future<void> loadShowApp() async {
    String isLogin = tokenBox.get(StorageBox.currentToken, defaultValue: "").toString();

    Future.delayed(const Duration(seconds: 2), () {
      UserService.instance.setCurrentToken(isLogin);
      if (isLogin.isNotEmpty) {
        context.router.replace(const MainRoute());
      } else {
        context.router.replace(LoginRoute());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(R.ASSETS_PNG_LOGO_SPLASH_PNG),
      ),
    );
  }
}
