part of 'home_page_cubit.dart';

class HomePageState extends Equatable {
  final DataProfile profile;
  final APIRequestStatus notifyCationLocalStatus;
  final List<AnnouncementData> announcementData;
  final int totalUnread;
  const HomePageState(
      {required this.profile,
      required this.notifyCationLocalStatus,
      required this.announcementData,
      this.totalUnread = 0});

  HomePageState coppyWith(
      {DataProfile? profile,
      APIRequestStatus? notifyCationLocalStatus,
      List<AnnouncementData>? announcementData,
      int? totalUnread}) {
    return HomePageState(
        profile: profile ?? this.profile,
        notifyCationLocalStatus: notifyCationLocalStatus ?? this.notifyCationLocalStatus,
        announcementData: announcementData ?? this.announcementData,
        totalUnread: totalUnread ?? this.totalUnread);
  }

  @override
  List<Object> get props => [profile, notifyCationLocalStatus, announcementData, totalUnread];
}
