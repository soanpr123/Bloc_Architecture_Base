// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:auto_route/empty_router_widgets.dart' as _i4;
import 'package:flutter/material.dart' as _i11;

import '../../feautures/amai_store_page/amai_store_page.dart' as _i6;
import '../../feautures/change_password/change_password_page.dart' as _i9;
import '../../feautures/home_page/home_page.dart' as _i5;
import '../../feautures/infomation_profile_page/infomation_profile_page.dart'
    as _i8;
import '../../feautures/login_page/login_page.dart' as _i2;
import '../../feautures/main_page/main_page.dart' as _i3;
import '../../feautures/profile_page/profile_page.dart' as _i7;
import '../../feautures/splash_page/splash_page.dart' as _i1;

class Routers extends _i10.RootStackRouter {
  Routers([_i11.GlobalKey<_i11.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SplashPage(),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.LoginPage(key: args.key),
      );
    },
    MainRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.MainPage(),
      );
    },
    HomePageRouter.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    AmaiPageRouter.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    ProfilePageRouter.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.HomePage(),
      );
    },
    AmaiStoreRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.AmaiStorePage(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.ProfilePage(),
      );
    },
    InfomationProfileRoute.name: (routeData) {
      final args = routeData.argsAs<InfomationProfileRouteArgs>(
          orElse: () => const InfomationProfileRouteArgs());
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.InfomationProfilePage(key: args.key),
      );
    },
    ChangePasswordRoute.name: (routeData) {
      final args = routeData.argsAs<ChangePasswordRouteArgs>(
          orElse: () => const ChangePasswordRouteArgs());
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i9.ChangePasswordPage(key: args.key),
      );
    },
  };

  @override
  List<_i10.RouteConfig> get routes => [
        _i10.RouteConfig(
          SplashRoute.name,
          path: '/',
        ),
        _i10.RouteConfig(
          LoginRoute.name,
          path: '/login',
        ),
        _i10.RouteConfig(
          MainRoute.name,
          path: '/main',
          children: [
            _i10.RouteConfig(
              HomePageRouter.name,
              path: 'home',
              parent: MainRoute.name,
              children: [
                _i10.RouteConfig(
                  HomeRoute.name,
                  path: '',
                  parent: HomePageRouter.name,
                ),
                _i10.RouteConfig(
                  '*#redirect',
                  path: '*',
                  parent: HomePageRouter.name,
                  redirectTo: '',
                  fullMatch: true,
                ),
              ],
            ),
            _i10.RouteConfig(
              AmaiPageRouter.name,
              path: 'amaiStore',
              parent: MainRoute.name,
              children: [
                _i10.RouteConfig(
                  AmaiStoreRoute.name,
                  path: '',
                  parent: AmaiPageRouter.name,
                ),
                _i10.RouteConfig(
                  '*#redirect',
                  path: '*',
                  parent: AmaiPageRouter.name,
                  redirectTo: '',
                  fullMatch: true,
                ),
              ],
            ),
            _i10.RouteConfig(
              ProfilePageRouter.name,
              path: 'profile',
              parent: MainRoute.name,
              children: [
                _i10.RouteConfig(
                  ProfileRoute.name,
                  path: '',
                  parent: ProfilePageRouter.name,
                ),
                _i10.RouteConfig(
                  InfomationProfileRoute.name,
                  path: 'info',
                  parent: ProfilePageRouter.name,
                ),
                _i10.RouteConfig(
                  ChangePasswordRoute.name,
                  path: 'chane_pass',
                  parent: ProfilePageRouter.name,
                ),
                _i10.RouteConfig(
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
/// [_i1.SplashPage]
class SplashRoute extends _i10.PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.LoginPage]
class LoginRoute extends _i10.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i11.Key? key})
      : super(
          LoginRoute.name,
          path: '/login',
          args: LoginRouteArgs(key: key),
        );

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final _i11.Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.MainPage]
class MainRoute extends _i10.PageRouteInfo<void> {
  const MainRoute({List<_i10.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          path: '/main',
          initialChildren: children,
        );

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class HomePageRouter extends _i10.PageRouteInfo<void> {
  const HomePageRouter({List<_i10.PageRouteInfo>? children})
      : super(
          HomePageRouter.name,
          path: 'home',
          initialChildren: children,
        );

  static const String name = 'HomePageRouter';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class AmaiPageRouter extends _i10.PageRouteInfo<void> {
  const AmaiPageRouter({List<_i10.PageRouteInfo>? children})
      : super(
          AmaiPageRouter.name,
          path: 'amaiStore',
          initialChildren: children,
        );

  static const String name = 'AmaiPageRouter';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class ProfilePageRouter extends _i10.PageRouteInfo<void> {
  const ProfilePageRouter({List<_i10.PageRouteInfo>? children})
      : super(
          ProfilePageRouter.name,
          path: 'profile',
          initialChildren: children,
        );

  static const String name = 'ProfilePageRouter';
}

/// generated route for
/// [_i5.HomePage]
class HomeRoute extends _i10.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i6.AmaiStorePage]
class AmaiStoreRoute extends _i10.PageRouteInfo<void> {
  const AmaiStoreRoute()
      : super(
          AmaiStoreRoute.name,
          path: '',
        );

  static const String name = 'AmaiStoreRoute';
}

/// generated route for
/// [_i7.ProfilePage]
class ProfileRoute extends _i10.PageRouteInfo<void> {
  const ProfileRoute()
      : super(
          ProfileRoute.name,
          path: '',
        );

  static const String name = 'ProfileRoute';
}

/// generated route for
/// [_i8.InfomationProfilePage]
class InfomationProfileRoute
    extends _i10.PageRouteInfo<InfomationProfileRouteArgs> {
  InfomationProfileRoute({_i11.Key? key})
      : super(
          InfomationProfileRoute.name,
          path: 'info',
          args: InfomationProfileRouteArgs(key: key),
        );

  static const String name = 'InfomationProfileRoute';
}

class InfomationProfileRouteArgs {
  const InfomationProfileRouteArgs({this.key});

  final _i11.Key? key;

  @override
  String toString() {
    return 'InfomationProfileRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i9.ChangePasswordPage]
class ChangePasswordRoute extends _i10.PageRouteInfo<ChangePasswordRouteArgs> {
  ChangePasswordRoute({_i11.Key? key})
      : super(
          ChangePasswordRoute.name,
          path: 'chane_pass',
          args: ChangePasswordRouteArgs(key: key),
        );

  static const String name = 'ChangePasswordRoute';
}

class ChangePasswordRouteArgs {
  const ChangePasswordRouteArgs({this.key});

  final _i11.Key? key;

  @override
  String toString() {
    return 'ChangePasswordRouteArgs{key: $key}';
  }
}
