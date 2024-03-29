import 'package:auto_route/auto_route.dart';

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

import '../app.dart';

class MyApp extends StatefulWidget {
  const MyApp({required this.initialResource, Key? key}) : super(key: key);
  final LoadInitialResourceOutput initialResource;
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends BasePageState<MyApp, AppBloc> {
  final _appRouter = GetIt.instance.get<AppRouter>();

  @override
  bool get isAppWidget => true;
  @override
  void initState() {
    super.initState();
    bloc.add(const AppInitiated(handleErr: false));
  }

  @override
  Widget buildPage(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(DeviceConstants.designDeviceWidth, DeviceConstants.designDeviceHeight),
      minTextAdapt: true,
      splitScreenMode: true,
      rebuildFactor: RebuildFactors.all,
      builder: (context, _) => MaterialApp.router(
        
        // routerConfig: _appRouter.config(),
        theme: ThemeData(
          primaryColor: colorBrandPrimary,
          // canvasColor: Colors.transparent,
        ),
        builder: (context, child) {
          final MediaQueryData data = MediaQuery.of(context);

          return MediaQuery(
            data: data.copyWith(textScaleFactor: 1.0),
            child: child ?? const SizedBox.shrink(),
          );
        },
        routerDelegate: _appRouter.delegate(
          // deepLinkBuilder: _mapRouteToPageRouteInfo(widget.initialResource),
          // initialRoutes: _mapRouteToPageRouteInfo(widget.initialResource),
          deepLinkBuilder: (deepLink) => DeepLink(_mapRouteToPageRouteInfo(widget.initialResource)),
          navigatorObservers: () => [AppNavigatorObserver()],
        ),
        routeInformationParser: _appRouter.defaultRouteParser(),
        title: 'Internal_App',
        debugShowCheckedModeBanner: false,
        localeResolutionCallback: (Locale? locale, Iterable<Locale> supportedLocales) =>
            supportedLocales.contains(locale) ? locale : const Locale(LocaleConstants.defaultLocale),
        locale: const Locale('vi'),
        supportedLocales: S.delegate.supportedLocales,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    );
  }

  List<PageRouteInfo> _mapRouteToPageRouteInfo(LoadInitialResourceOutput initialResource) {
    return initialResource.initialRoutes.map((e) {
      switch (e) {
        case AppRoute.splash:
          return const SplashRoute();
        case AppRoute.login:
          return const LoginRoute();
      }
    }).toList(growable: false);
  }
}
