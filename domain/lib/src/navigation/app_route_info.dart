import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_route_info.freezed.dart';

/// page
@freezed
class AppRouteInfo with _$AppRouteInfo {
  const factory AppRouteInfo.login() = _Login;
  const factory AppRouteInfo.splash() = _Splash;
  const factory AppRouteInfo.main() = _Main;
  const factory AppRouteInfo.infomationProfile() = _InfomationProfile;
  const factory AppRouteInfo.amaiStore() = _AmaiStorePage;
  const factory AppRouteInfo.announcementDetail(String slungs) = _AnnouncementDetailPage;
  const factory AppRouteInfo.qrCode() = _QrCode;
  const factory AppRouteInfo.paymentAmai(int amount) = _Payment;
  const factory AppRouteInfo.paymentResult() = _PaymentResult;
  const factory AppRouteInfo.changePassWord() = _ChangePassWord;
  const factory AppRouteInfo.announmentPage() = _AnnounmentPage;
  const factory AppRouteInfo.featureDevelop() = _FeatureDevelop;
  const factory AppRouteInfo.wikiPage() = _WikiPage;
  const factory AppRouteInfo.wikiDetailPage(String slungs) = _WikiDetailPage;
  const factory AppRouteInfo.blogsDetail(String slungs) = _BlogsDetail;
  const factory AppRouteInfo.amaiMember() = _AmaiMember;
  const factory AppRouteInfo.listBlogsPage(String tag) = _ListBlogsPage;
  const factory AppRouteInfo.reportPage() = _ReportPage;
  const factory AppRouteInfo.sendAmai(int userId) = _SendAmai;
  const factory AppRouteInfo.doneSendAmaiPage(int userId) = _DoneSendAmaiPage;
  const factory AppRouteInfo.myQrCodePage(String qrCode, String name) = _MyQrCodePage;
  const factory AppRouteInfo.leaderBroad() = _LeaderBroad;
  // const factory AppRouteInfo.itemDetail(User user) = _UserDetail;
}
