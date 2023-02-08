import 'package:auto_route/annotations.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:project/core/routers/auth_guard.dart';
import 'package:project/feautures/amai_store_page/amai_store_page.dart';

import 'package:project/feautures/home_page/home_page.dart';
import 'package:project/feautures/login_page/login_page.dart';
import 'package:project/feautures/main_page/main_page.dart';
import 'package:project/feautures/profile_page/profile_page.dart';
import 'package:project/feautures/splash_page/splash_page.dart';

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
        RedirectRoute(path: '*', redirectTo: ''),
      ]),
    ]),
  ],
  replaceInRouteName: 'Page,Route',
)
class $Routers {}
