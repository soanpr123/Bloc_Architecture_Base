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
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:auto_route/empty_router_widgets.dart' as _i4;
import 'package:flutter/cupertino.dart' as _i10;
import 'package:flutter/material.dart' as _i9;

import '../../feautures/amai_store_page/amai_store_page.dart' as _i6;
import '../../feautures/home_page/home_page.dart' as _i5;
import '../../feautures/login_page/login_page.dart' as _i2;
import '../../feautures/main_page/main_page.dart' as _i3;
import '../../feautures/profile_page/profile_page.dart' as _i7;
import '../../feautures/splash_page/splash_page.dart' as _i1;

class Routers extends _i8.RootStackRouter {
  Routers([_i9.GlobalKey<_i9.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SplashPage(),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.LoginPage(key: args.key),
      );
    },
    MainRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.MainPage(),
      );
    },
    HomePageRouter.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    AmaiPageRouter.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    ProfilePageRouter.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.HomePage(),
      );
    },
    AmaiStoreRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.AmaiStorePage(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.ProfilePage(),
      );
    },
  };

  @override
  List<_i8.RouteConfig> get routes => [
        _i8.RouteConfig(
          SplashRoute.name,
          path: '/',
        ),
        _i8.RouteConfig(
          LoginRoute.name,
          path: '/login',
        ),
        _i8.RouteConfig(
          MainRoute.name,
          path: '/main',
          children: [
            _i8.RouteConfig(
              HomePageRouter.name,
              path: 'home',
              parent: MainRoute.name,
              children: [
                _i8.RouteConfig(
                  HomeRoute.name,
                  path: '',
                  parent: HomePageRouter.name,
                ),
                _i8.RouteConfig(
                  '*#redirect',
                  path: '*',
                  parent: HomePageRouter.name,
                  redirectTo: '',
                  fullMatch: true,
                ),
              ],
            ),
            _i8.RouteConfig(
              AmaiPageRouter.name,
              path: 'amaiStore',
              parent: MainRoute.name,
              children: [
                _i8.RouteConfig(
                  AmaiStoreRoute.name,
                  path: '',
                  parent: AmaiPageRouter.name,
                ),
                _i8.RouteConfig(
                  '*#redirect',
                  path: '*',
                  parent: AmaiPageRouter.name,
                  redirectTo: '',
                  fullMatch: true,
                ),
              ],
            ),
            _i8.RouteConfig(
              ProfilePageRouter.name,
              path: 'profile',
              parent: MainRoute.name,
              children: [
                _i8.RouteConfig(
                  ProfileRoute.name,
                  path: '',
                  parent: ProfilePageRouter.name,
                ),
                _i8.RouteConfig(
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
class SplashRoute extends _i8.PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.LoginPage]
class LoginRoute extends _i8.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i10.Key? key})
      : super(
          LoginRoute.name,
          path: '/login',
          args: LoginRouteArgs(key: key),
        );

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final _i10.Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.MainPage]
class MainRoute extends _i8.PageRouteInfo<void> {
  const MainRoute({List<_i8.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          path: '/main',
          initialChildren: children,
        );

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class HomePageRouter extends _i8.PageRouteInfo<void> {
  const HomePageRouter({List<_i8.PageRouteInfo>? children})
      : super(
          HomePageRouter.name,
          path: 'home',
          initialChildren: children,
        );

  static const String name = 'HomePageRouter';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class AmaiPageRouter extends _i8.PageRouteInfo<void> {
  const AmaiPageRouter({List<_i8.PageRouteInfo>? children})
      : super(
          AmaiPageRouter.name,
          path: 'amaiStore',
          initialChildren: children,
        );

  static const String name = 'AmaiPageRouter';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class ProfilePageRouter extends _i8.PageRouteInfo<void> {
  const ProfilePageRouter({List<_i8.PageRouteInfo>? children})
      : super(
          ProfilePageRouter.name,
          path: 'profile',
          initialChildren: children,
        );

  static const String name = 'ProfilePageRouter';
}

/// generated route for
/// [_i5.HomePage]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i6.AmaiStorePage]
class AmaiStoreRoute extends _i8.PageRouteInfo<void> {
  const AmaiStoreRoute()
      : super(
          AmaiStoreRoute.name,
          path: '',
        );

  static const String name = 'AmaiStoreRoute';
}

/// generated route for
/// [_i7.ProfilePage]
class ProfileRoute extends _i8.PageRouteInfo<void> {
  const ProfileRoute()
      : super(
          ProfileRoute.name,
          path: '',
        );

  static const String name = 'ProfileRoute';
}
