part of 'home_page_cubit.dart';

class HomePageState extends Equatable {
  final DataProfile profile;
  final APIRequestStatus notifyCationLocalStatus;
  final List<AnnouncementData> announcementData;
  const HomePageState({required this.profile, required this.notifyCationLocalStatus, required this.announcementData});

  HomePageState coppyWith(
      {DataProfile? profile, APIRequestStatus? notifyCationLocalStatus, List<AnnouncementData>? announcementData}) {
    return HomePageState(
        profile: profile ?? this.profile,
        notifyCationLocalStatus: notifyCationLocalStatus ?? this.notifyCationLocalStatus,
        announcementData: announcementData ?? this.announcementData);
  }

  @override
  List<Object> get props => [profile, notifyCationLocalStatus, announcementData];
}
