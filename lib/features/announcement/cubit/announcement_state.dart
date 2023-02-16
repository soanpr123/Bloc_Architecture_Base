part of 'announcement_cubit.dart';

 class AnnouncementState extends Equatable {
  final APIRequestStatus notifyCationLocalStatus;
  final List<AnnouncementData> announcementData;
  final bool onReload;
  final int page;
  final bool enablePull;
  const AnnouncementState(
      {required this.notifyCationLocalStatus,
      required this.announcementData,
      this.onReload = false,
      this.page = 1,
      this.enablePull = true});

  AnnouncementState coppyWith(
      {
      APIRequestStatus? notifyCationLocalStatus,
      List<AnnouncementData>? announcementData,
      bool? onReload,
      int? page,
      bool? enablePull}) {
    return AnnouncementState(
      
        notifyCationLocalStatus: notifyCationLocalStatus ?? this.notifyCationLocalStatus,
        announcementData: announcementData ?? this.announcementData,
        onReload: onReload ?? this.onReload,
        page: page ?? this.page,
        enablePull: enablePull ?? this.enablePull);
  }

  @override
  List<Object> get props => [ notifyCationLocalStatus, announcementData, onReload, page, enablePull];
}

