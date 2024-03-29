import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../app.dart';

@LazySingleton(as: BaseRouteInfoMapper)
class AppRouteInfoMapper extends BaseRouteInfoMapper {
  @override
  PageRouteInfo map(AppRouteInfo appRouteInfo) {
    return appRouteInfo.when(
      login: () => const LoginRoute(),
      splash: () => const SplashRoute(),
      main: () => const MainRoute(),
      infomationProfile: () => const InfomationProfileRoute(),
      amaiStore: () => const AmaiStoreRoute(),
      announcementDetail: (s) => AnnouncementDetailRoute(slungs: s),
      qrCode: () => const QrCodeRoute(),
      paymentAmai: (int amount) => PaymentAmaiRoute(amountAmai: amount),
      paymentResult: () => const AmaiStoreRoute(),
      changePassWord: () => const ChangePassRoute(),
      announmentPage: () => const AnnounmentRoute(),
      featureDevelop: () => const FeatureDeveloperRoute(),
      wikiPage: () => const WikiRoute(),
      wikiDetailPage: (slungs) => WikiDetailRoute(slungs: slungs),
      blogsDetail: (slungs) => BlogsDetailRoute(slungs: slungs),
      amaiMember: () => const AmaiMemberRoute(),
      reportPage: () => const ReportRoute(),
      listBlogsPage: (String tag) => ListBlogsRoute(tag: tag),
      sendAmai: (int userId) => SendAmaiRoute(userId: userId.toString()),
      doneSendAmaiPage: (int userId) => DoneSendAmaiRoute(userId: userId),
      myQrCodePage: (qrCode, name) => MyQrCodeRoute(qrCode: qrCode, name: name),
      leaderBroad: () => const RankingRoute(),
      // itemDetail: (user) => ItemDetailRoute(user: user),
    );
  }
}
