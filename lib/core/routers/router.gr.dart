// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const SplashPage(),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: LoginPage(key: args.key),
      );
    },
    MainRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const MainPage(),
      );
    },
    HomePageRouter.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const EmptyRouterPage(),
      );
    },
    AmaiPageRouter.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const EmptyRouterPage(),
      );
    },
    ProfilePageRouter.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const EmptyRouterPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: HomePage(),
      );
    },
    AmaiStoreRoute.name: (routeData) {
      final args = routeData.argsAs<AmaiStoreRouteArgs>(
          orElse: () => const AmaiStoreRouteArgs());
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: AmaiStorePage(key: args.key),
      );
    },
    ProfileRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const ProfilePage(),
      );
    },
    InfomationProfileRoute.name: (routeData) {
      final args = routeData.argsAs<InfomationProfileRouteArgs>(
          orElse: () => const InfomationProfileRouteArgs());
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: InfomationProfilePage(key: args.key),
      );
    },
    ChangePasswordRoute.name: (routeData) {
      final args = routeData.argsAs<ChangePasswordRouteArgs>(
          orElse: () => const ChangePasswordRouteArgs());
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: ChangePasswordPage(key: args.key),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          SplashRoute.name,
          path: '/',
        ),
        RouteConfig(
          LoginRoute.name,
          path: '/login',
        ),
        RouteConfig(
          MainRoute.name,
          path: '/main',
          children: [
            RouteConfig(
              HomePageRouter.name,
              path: 'home',
              parent: MainRoute.name,
              children: [
                RouteConfig(
                  HomeRoute.name,
                  path: '',
                  parent: HomePageRouter.name,
                ),
                RouteConfig(
                  '*#redirect',
                  path: '*',
                  parent: HomePageRouter.name,
                  redirectTo: '',
                  fullMatch: true,
                ),
              ],
            ),
            RouteConfig(
              AmaiPageRouter.name,
              path: 'amaiStore',
              parent: MainRoute.name,
              children: [
                RouteConfig(
                  AmaiStoreRoute.name,
                  path: '',
                  parent: AmaiPageRouter.name,
                ),
                RouteConfig(
                  '*#redirect',
                  path: '*',
                  parent: AmaiPageRouter.name,
                  redirectTo: '',
                  fullMatch: true,
                ),
              ],
            ),
            RouteConfig(
              ProfilePageRouter.name,
              path: 'profile',
              parent: MainRoute.name,
              children: [
                RouteConfig(
                  ProfileRoute.name,
                  path: '',
                  parent: ProfilePageRouter.name,
                ),
                RouteConfig(
                  InfomationProfileRoute.name,
                  path: 'info',
                  parent: ProfilePageRouter.name,
                ),
                RouteConfig(
                  ChangePasswordRoute.name,
                  path: 'chane_pass',
                  parent: ProfilePageRouter.name,
                ),
                RouteConfig(
                  '*#redirect',
                  path: '*',
                  parent: ProfilePageRouter.name,
                  redirectTo: '',
                  fullMatch: true,
                ),
              ],
            ),
          ],
        ),
      ];
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<LoginRouteArgs> {
  LoginRoute({Key? key})
      : super(
          LoginRoute.name,
          path: '/login',
          args: LoginRouteArgs(key: key),
        );

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [MainPage]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          path: '/main',
          initialChildren: children,
        );

  static const String name = 'MainRoute';
}

/// generated route for
/// [EmptyRouterPage]
class HomePageRouter extends PageRouteInfo<void> {
  const HomePageRouter({List<PageRouteInfo>? children})
      : super(
          HomePageRouter.name,
          path: 'home',
          initialChildren: children,
        );

  static const String name = 'HomePageRouter';
}

/// generated route for
/// [EmptyRouterPage]
class AmaiPageRouter extends PageRouteInfo<void> {
  const AmaiPageRouter({List<PageRouteInfo>? children})
      : super(
          AmaiPageRouter.name,
          path: 'amaiStore',
          initialChildren: children,
        );

  static const String name = 'AmaiPageRouter';
}

/// generated route for
/// [EmptyRouterPage]
class ProfilePageRouter extends PageRouteInfo<void> {
  const ProfilePageRouter({List<PageRouteInfo>? children})
      : super(
          ProfilePageRouter.name,
          path: 'profile',
          initialChildren: children,
        );

  static const String name = 'ProfilePageRouter';
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [AmaiStorePage]
class AmaiStoreRoute extends PageRouteInfo<AmaiStoreRouteArgs> {
  AmaiStoreRoute({Key? key})
      : super(
          AmaiStoreRoute.name,
          path: '',
          args: AmaiStoreRouteArgs(key: key),
        );

  static const String name = 'AmaiStoreRoute';
}

class AmaiStoreRouteArgs {
  const AmaiStoreRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'AmaiStoreRouteArgs{key: $key}';
  }
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute()
      : super(
          ProfileRoute.name,
          path: '',
        );

  static const String name = 'ProfileRoute';
}

/// generated route for
/// [InfomationProfilePage]
class InfomationProfileRoute extends PageRouteInfo<InfomationProfileRouteArgs> {
  InfomationProfileRoute({Key? key})
      : super(
          InfomationProfileRoute.name,
          path: 'info',
          args: InfomationProfileRouteArgs(key: key),
        );

  static const String name = 'InfomationProfileRoute';
}

class InfomationProfileRouteArgs {
  const InfomationProfileRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'InfomationProfileRouteArgs{key: $key}';
  }
}

/// generated route for
/// [ChangePasswordPage]
class ChangePasswordRoute extends PageRouteInfo<ChangePasswordRouteArgs> {
  ChangePasswordRoute({Key? key})
      : super(
          ChangePasswordRoute.name,
          path: 'chane_pass',
          args: ChangePasswordRouteArgs(key: key),
        );

  static const String name = 'ChangePasswordRoute';
}

class ChangePasswordRouteArgs {
  const ChangePasswordRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'ChangePasswordRouteArgs{key: $key}';
  }
}
