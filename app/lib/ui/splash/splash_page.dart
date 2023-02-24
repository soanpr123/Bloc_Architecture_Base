import 'package:flutter/material.dart';

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
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
              top: 50,
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
          ],
        ),
      ),
    );
  }
}
