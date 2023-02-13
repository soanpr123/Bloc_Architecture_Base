import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:project/core/routers/router.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
class MyApp extends StatelessWidget {
  final appRoute = AppRouter();
  final tokenBox = GetIt.I<Box<String>>();

  MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('vi'),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate: appRoute.delegate(
        navigatorObservers: () => [AutoRouteObserver()],
      ),
      
      // routerDelegate: AutoRouterDelegate.declarative(appRoute,
      //     routes: (_) =>
      //         [if (tokenBox.get('token', defaultValue: "").toString().isEmpty) const MainRoute() else LoginRoute()]),
      routeInformationParser: appRoute.defaultRouteParser(),
      
    );
  }
}
