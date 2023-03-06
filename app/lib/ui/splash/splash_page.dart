import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared/shared.dart';

import '../../app.dart';
import 'bloc/splash_bloc.dart';
import 'bloc/splash_event.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends BasePageState<SplashPage, SplashBloc> {
  @override
  void initState() {
    super.initState();
    bloc.add(const SplashInitiated());
  }

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      body: Container(
        // width:DeviceConst,
        // height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: colorGradientBrandPrimary,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Opacity(
                    opacity: 0.2,
                    child: Image.asset(
                      Assets.png.imgBg.path,
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
                  Image.asset(Assets.png.logoSplashWhite.path),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Nurturing Innovation',
                    style: typoInterNomal18.copyWith(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: Dimens.d40.responsive()),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Version ${GetIt.instance.get<AppInfo>().versionName}',
                  style: typoInterNomal14.copyWith(
                      color: Colors.white, fontSize: Dimens.d14.responsive(), height: 1.5, fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
