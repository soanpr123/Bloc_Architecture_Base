import 'package:auto_route/annotations.dart';

import 'package:project/feautures/home_page/home_page.dart';
import 'package:project/feautures/login_page/login_page.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: LoginPage, initial: true),
    AutoRoute(page: HomePage, path: "/home"),
    RedirectRoute(path: '*', redirectTo: '/'),
  ],
  replaceInRouteName: 'Page,Route',
)
class $Routers {}
