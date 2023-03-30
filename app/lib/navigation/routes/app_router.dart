import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
// import 'package:auto_route/empty_router_widgets.dart';

import '../../app.dart';
import '../../ui/infomation_profile_page/infomation_profile_page.dart';

// ignore_for_file:avoid-dynamic
@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute<dynamic>(page: SplashPage, initial: true),
    AutoRoute<dynamic>(
      page: LoginPage,
    ),
    mainScreenRouter,
    AutoRoute<dynamic>(
      page: QrCodePage,
    ),
    AutoRoute<dynamic>(
      page: PaymentAmaiPage,
    ),
    AutoRoute<dynamic>(page: AnnouncementDetailPage),
    AutoRoute<dynamic>(page: FeatureDeveloperPage),
    AutoRoute<dynamic>(page: WikiDetailPage),
    AutoRoute<dynamic>(page: BlogsDetailPage),
    AutoRoute<dynamic>(page: AmaiMemberPage),
    AutoRoute<dynamic>(page: ListBlogsPage),
    AutoRoute<dynamic>(page: SendAmaiPage),
    AutoRoute<dynamic>(page: DoneSendAmaiPage),
    AutoRoute<dynamic>(page: MyQrCodePage),
  ],
)
class $AppRouter {}

const mainScreenRouter = CustomRoute<dynamic>(
  transitionsBuilder: TransitionsBuilders.fadeIn,
  durationInMilliseconds: 200,
  page: MainPage,
  guards: [RouteGuard],
  children: [
    AutoRoute<dynamic>(
      name: 'BottomTabHomeRouter',
      page: EmptyRouterPage,
      children: [
        AutoRoute<dynamic>(page: HomePage, initial: true),
        AutoRoute<dynamic>(page: AmaiStorePage, initial: true),
        AutoRoute<dynamic>(page: AnnounmentPage, initial: true),
        AutoRoute<dynamic>(page: WikiPage, initial: true),
      ],
    ),
    AutoRoute<dynamic>(
      name: 'BottomTabHistoryRouter',
      page: EmptyRouterPage,
      children: [
        AutoRoute<dynamic>(page: HistoryAmaiPage, initial: true),
      ],
    ),
    AutoRoute<dynamic>(
      name: 'BottomTabNotifiRouter',
      page: EmptyRouterPage,
      children: [
        AutoRoute<dynamic>(page: NotificationPage, initial: true),
        AutoRoute<dynamic>(page: AmaiStorePage, initial: true),
      ],
    ),
    AutoRoute<dynamic>(
      name: 'BottomTabProfileRouter',
      page: EmptyRouterPage,
      children: [
        AutoRoute<dynamic>(page: ProfilePage, initial: true),
        AutoRoute<dynamic>(page: InfomationProfilePage, initial: true),
        AutoRoute<dynamic>(page: ChangePassPage, initial: true),
      ],
    ),
  ],
);
