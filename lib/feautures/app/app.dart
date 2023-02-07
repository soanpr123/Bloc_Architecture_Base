import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:project/core/routers/router.gr.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  final appRoute = Routers();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale('vi'),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate: appRoute.delegate(
        navigatorObservers: () => [AutoRouteObserver()],
      ),
      routeInformationParser: appRoute.defaultRouteParser(),
    );
  }
}
