import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:project/core/di/dependency_injection.dart';
import 'package:project/core/routers/router.dart';
import 'package:project/core/sevices/user_service.dart';
import 'package:project/core/style/colors.dart';
import 'package:project/core/style/resource.dart';
import 'package:project/core/style/text_style.dart';
import 'package:project/core/utils/constants.dart';
import 'package:project/features/internal_app/data/repository/internal_app_repository.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final tokenBox = GetIt.I<Box<String>>();
  final responsitory = getIt.get<InternalAppRepository>();
  @override
  void initState() {
    super.initState();
    loadShowApp();
  }

  Future<void> loadShowApp() async {
    String isLogin = tokenBox.get(StorageBox.currentToken, defaultValue: "").toString();

    UserService.instance.setCurrentToken(isLogin);
    if (isLogin.isNotEmpty) {
      await getProfile();
    } else {
      context.router.replace(LoginRoute());
    }
  }

  Future<void> getProfile() async {
    try {
      final response = await responsitory.requestMe();
      if (response.statusCode == 200) {
        if (context.mounted) context.router.replace(const MainRoute());
      } else {
        if (context.mounted) context.router.replace(LoginRoute());
      }
    } catch (e) {
      context.router.replace(LoginRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: colorGradientBrandPrimary, begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: 50,
              bottom: 0,
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Opacity(
                    opacity: 0.2,
                    child: Image.asset(
                      R.ASSETS_PNG_IMG_BG_PNG,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              left: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(R.ASSETS_PNG_LOGO_SPLASH_WHITE_PNG),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Nurturing Innovation",
                    style: typoInterNomal18.copyWith(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
