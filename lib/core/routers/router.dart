import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:flutter/material.dart';
// import 'package:project/core/routers/auth_guard.dart';
import 'package:project/features/amai_store_page/amai_store_page.dart';
import 'package:project/features/change_password/change_password_page.dart';

import 'package:project/features/home_page/home_page.dart';
import 'package:project/features/infomation_profile_page/infomation_profile_page.dart';
import 'package:project/features/login_page/login_page.dart';
import 'package:project/features/main_page/main_page.dart';
import 'package:project/features/profile_page/profile_page.dart';
import 'package:project/features/splash_page/splash_page.dart';
part 'router.gr.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, initial: true, path: "/"),
    AutoRoute(page: LoginPage, path: "/login"),
    AutoRoute(page: MainPage, path: "/main", children: [
      AutoRoute(page: EmptyRouterPage, path: "home", name: "HomePageRouter", children: [
        AutoRoute(path: '', page: HomePage),
        RedirectRoute(path: '*', redirectTo: ''),
      ]),
      AutoRoute(page: EmptyRouterPage, path: "amaiStore", name: "AmaiPageRouter", children: [
        AutoRoute(path: '', page: AmaiStorePage),
        RedirectRoute(path: '*', redirectTo: ''),
      ]),
      AutoRoute(page: EmptyRouterPage, path: "profile", name: "ProfilePageRouter", children: [
        AutoRoute(path: '', page: ProfilePage),
        AutoRoute(path: 'info', page: InfomationProfilePage),
        AutoRoute(path: 'chane_pass', page: ChangePasswordPage),
        RedirectRoute(path: '*', redirectTo: ''),
      ]),
    ]),
  ],
  replaceInRouteName: 'Page,Route',
)
class AppRouter extends _$AppRouter {
  AppRouter._();

  static AppRouter? _instance;
  factory AppRouter() => _instance ??= AppRouter._();
}
