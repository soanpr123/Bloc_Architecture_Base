part of 'home_page_cubit.dart';

class HomePageState extends Equatable {
  final DataProfile profile;
  final APIRequestStatus notifyCationLocalStatus;
  final List<AnnouncementData> announcementData;
  final int totalUnread;
  final double temp;
  const HomePageState(
      {required this.profile,
      required this.notifyCationLocalStatus,
      required this.announcementData,
      this.temp = 0,
      this.totalUnread = 0});

  HomePageState coppyWith(
      {DataProfile? profile,
      APIRequestStatus? notifyCationLocalStatus,
      List<AnnouncementData>? announcementData,
      int? totalUnread,
      double? temp}) {
    return HomePageState(
        profile: profile ?? this.profile,
        notifyCationLocalStatus: notifyCationLocalStatus ?? this.notifyCationLocalStatus,
        announcementData: announcementData ?? this.announcementData,
        totalUnread: totalUnread ?? this.totalUnread,
        temp: temp ?? this.temp);
  }

  @override
  List<Object> get props => [profile, notifyCationLocalStatus, announcementData, totalUnread, temp];
}
