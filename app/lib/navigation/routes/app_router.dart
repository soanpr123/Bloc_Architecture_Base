import 'package:auto_route/auto_route.dart';
import 'package:get_it/get_it.dart';

// import 'package:auto_route/empty_router_widgets.dart';

import '../../app.dart';


@AutoRouterConfig(
  replaceInRouteName: 'Page,Route',
)
class AppRouter extends $AppRouter {
    @override
  final List<AutoRoute> routes = [
    AutoRoute(page: SplashRoute.page, path: '/'),
    AutoRoute(page: LoginRoute.page),
    CustomRoute(
      transitionsBuilder: TransitionsBuilders.fadeIn,
      durationInMilliseconds: 200,
      page: MainRoute.page,
      guards: [
        GetIt.instance.get<RouteGuard>(),
      ],
      children: [
        AutoRoute(page: TabHomeRouter.page, children: [
          AutoRoute(page: HomeRoute.page, path: ''),
          AutoRoute(page: AmaiStoreRoute.page, path: ''),
          AutoRoute(page: AnnounmentRoute.page, path: ''),
          AutoRoute(page: WikiRoute.page, path: ''),
        ]),
        AutoRoute(page: TabHistoryRouter.page, children: [
          AutoRoute(page: HistoryAmaiRoute.page, path: ''),
        ]),
        AutoRoute(page: TabNotifiRouter.page, children: [
          AutoRoute(page: NotificationRoute.page, path: ''),
          AutoRoute(page: AmaiStoreRoute.page, path: ''),
        ]),
        AutoRoute(page: TabProfileRouter.page, children: [
          AutoRoute(page: ProfileRoute.page, path: ''),
          AutoRoute(page: InfomationProfileRoute.page, path: ''),
          AutoRoute(page: ChangePassRoute.page, path: ''),
        ]),
      ],
    ),
    AutoRoute(page: QrCodeRoute.page),
    AutoRoute(page: PaymentAmaiRoute.page),
    AutoRoute(page: AnnouncementDetailRoute.page),
    AutoRoute(page: FeatureDeveloperRoute.page),
    AutoRoute(page: WikiDetailRoute.page),
    AutoRoute(page: BlogsDetailRoute.page),
    AutoRoute(page: AmaiMemberRoute.page),
    AutoRoute(page: ReportRoute.page),
    AutoRoute(page: ListBlogsRoute.page),
    AutoRoute(page: SendAmaiRoute.page),
    AutoRoute(page: DoneSendAmaiRoute.page),
    AutoRoute(page: MyQrCodeRoute.page),
  ];
  @override
  RouteType get defaultRouteType => const RouteType.material();


  
}

@RoutePage(name: 'TabHomeRouter')
class BottomTabHomeRouter extends AutoRouter {
  const BottomTabHomeRouter({super.key});
}

@RoutePage(name: 'TabHistoryRouter')
class BottomTabHistoryRouter extends AutoRouter {
  const BottomTabHistoryRouter({super.key});
}

@RoutePage(name: 'TabNotifiRouter')
class BottomTabNotifiRouter extends AutoRouter {
  const BottomTabNotifiRouter({super.key});
}

@RoutePage(name: 'TabProfileRouter')
class BottomTabProfileRouter extends AutoRouter {
  const BottomTabProfileRouter({super.key});
}
