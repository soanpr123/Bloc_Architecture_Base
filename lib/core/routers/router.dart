import 'package:auto_route/annotations.dart';
import 'package:project/feautures/app/app.dart';
import 'package:project/feautures/home_page/home_page.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    // AutoRoute(page: MyHomePage, initial: true),
    AutoRoute(page: HomePage, initial: true),
    RedirectRoute(path: '*', redirectTo: '/'),
  ],
  replaceInRouteName: 'Page,Route',
)
class $Routers {}
