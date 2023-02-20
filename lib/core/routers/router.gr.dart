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
    AnnouncementDetailRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<AnnouncementDetailRouteArgs>(
          orElse: () =>
              AnnouncementDetailRouteArgs(slug: pathParams.optString('slugs')));
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: AnnouncementDetailPage(
          key: args.key,
          slug: args.slug,
          useCase: args.useCase,
        ),
      );
    },
    QrCodeRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const QrCodePage(),
      );
    },
    PaymentAmaiRoute.name: (routeData) {
      final args = routeData.argsAs<PaymentAmaiRouteArgs>(
          orElse: () => const PaymentAmaiRouteArgs());
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: PaymentAmaiPage(key: args.key),
      );
    },
    HomePageRouter.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const EmptyRouterPage(),
      );
    },
    HistoryRouter.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const EmptyRouterPage(),
      );
    },
    NotifiCationRouter.name: (routeData) {
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
        child: const HomePage(),
      );
    },
    AnnouncementRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const AnnouncementPage(),
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
    HistoryQrRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const HistoryQrPage(),
      );
    },
    NotificationRoute.name: (routeData) {
      final args = routeData.argsAs<NotificationRouteArgs>(
          orElse: () => const NotificationRouteArgs());
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: NotificationPage(key: args.key),
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
                  AnnouncementRoute.name,
                  path: 'Annon',
                  parent: HomePageRouter.name,
                ),
                RouteConfig(
                  AmaiStoreRoute.name,
                  path: 'amai_store',
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
              HistoryRouter.name,
              path: 'history',
              parent: MainRoute.name,
              children: [
                RouteConfig(
                  HistoryQrRoute.name,
                  path: '',
                  parent: HistoryRouter.name,
                ),
                RouteConfig(
                  '*#redirect',
                  path: '*',
                  parent: HistoryRouter.name,
                  redirectTo: '',
                  fullMatch: true,
                ),
              ],
            ),
            RouteConfig(
              NotifiCationRouter.name,
              path: 'notification',
              parent: MainRoute.name,
              children: [
                RouteConfig(
                  NotificationRoute.name,
                  path: '',
                  parent: NotifiCationRouter.name,
                ),
                RouteConfig(
                  '*#redirect',
                  path: '*',
                  parent: NotifiCationRouter.name,
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
        RouteConfig(
          AnnouncementDetailRoute.name,
          path: '/detalAnnouncementPage/:slugs',
        ),
        RouteConfig(
          QrCodeRoute.name,
          path: '/qrcodePage',
        ),
        RouteConfig(
          PaymentAmaiRoute.name,
          path: '/amaiPayment',
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
/// [AnnouncementDetailPage]
class AnnouncementDetailRoute
    extends PageRouteInfo<AnnouncementDetailRouteArgs> {
  AnnouncementDetailRoute({
    Key? key,
    String? slug,
    String? useCase,
  }) : super(
          AnnouncementDetailRoute.name,
          path: '/detalAnnouncementPage/:slugs',
          args: AnnouncementDetailRouteArgs(
            key: key,
            slug: slug,
            useCase: useCase,
          ),
          rawPathParams: {'slugs': slug},
        );

  static const String name = 'AnnouncementDetailRoute';
}

class AnnouncementDetailRouteArgs {
  const AnnouncementDetailRouteArgs({
    this.key,
    this.slug,
    this.useCase,
  });

  final Key? key;

  final String? slug;

  final String? useCase;

  @override
  String toString() {
    return 'AnnouncementDetailRouteArgs{key: $key, slug: $slug, useCase: $useCase}';
  }
}

/// generated route for
/// [QrCodePage]
class QrCodeRoute extends PageRouteInfo<void> {
  const QrCodeRoute()
      : super(
          QrCodeRoute.name,
          path: '/qrcodePage',
        );

  static const String name = 'QrCodeRoute';
}

/// generated route for
/// [PaymentAmaiPage]
class PaymentAmaiRoute extends PageRouteInfo<PaymentAmaiRouteArgs> {
  PaymentAmaiRoute({Key? key})
      : super(
          PaymentAmaiRoute.name,
          path: '/amaiPayment',
          args: PaymentAmaiRouteArgs(key: key),
        );

  static const String name = 'PaymentAmaiRoute';
}

class PaymentAmaiRouteArgs {
  const PaymentAmaiRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'PaymentAmaiRouteArgs{key: $key}';
  }
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
class HistoryRouter extends PageRouteInfo<void> {
  const HistoryRouter({List<PageRouteInfo>? children})
      : super(
          HistoryRouter.name,
          path: 'history',
          initialChildren: children,
        );

  static const String name = 'HistoryRouter';
}

/// generated route for
/// [EmptyRouterPage]
class NotifiCationRouter extends PageRouteInfo<void> {
  const NotifiCationRouter({List<PageRouteInfo>? children})
      : super(
          NotifiCationRouter.name,
          path: 'notification',
          initialChildren: children,
        );

  static const String name = 'NotifiCationRouter';
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
/// [AnnouncementPage]
class AnnouncementRoute extends PageRouteInfo<void> {
  const AnnouncementRoute()
      : super(
          AnnouncementRoute.name,
          path: 'Annon',
        );

  static const String name = 'AnnouncementRoute';
}

/// generated route for
/// [AmaiStorePage]
class AmaiStoreRoute extends PageRouteInfo<AmaiStoreRouteArgs> {
  AmaiStoreRoute({Key? key})
      : super(
          AmaiStoreRoute.name,
          path: 'amai_store',
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
/// [HistoryQrPage]
class HistoryQrRoute extends PageRouteInfo<void> {
  const HistoryQrRoute()
      : super(
          HistoryQrRoute.name,
          path: '',
        );

  static const String name = 'HistoryQrRoute';
}

/// generated route for
/// [NotificationPage]
class NotificationRoute extends PageRouteInfo<NotificationRouteArgs> {
  NotificationRoute({Key? key})
      : super(
          NotificationRoute.name,
          path: '',
          args: NotificationRouteArgs(key: key),
        );

  static const String name = 'NotificationRoute';
}

class NotificationRouteArgs {
  const NotificationRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'NotificationRouteArgs{key: $key}';
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
