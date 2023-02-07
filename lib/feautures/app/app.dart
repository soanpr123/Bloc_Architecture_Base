import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:project/core/routers/router.gr.dart';

class MyApp extends StatelessWidget {
  final appRoute = Routers();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
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
