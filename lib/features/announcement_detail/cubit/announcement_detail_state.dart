part of 'announcement_detail_cubit.dart';

class AnnouncementDetailState extends Equatable {
  final APIRequestStatus apiRequestStatus;
  final DataDetail dataDetail;
  const AnnouncementDetailState({this.apiRequestStatus = APIRequestStatus.nodata, required this.dataDetail});
  AnnouncementDetailState coppyWith({APIRequestStatus? apiRequestStatus, DataDetail? dataDetail}) {
    return AnnouncementDetailState(
        apiRequestStatus: apiRequestStatus ?? this.apiRequestStatus, dataDetail: dataDetail ?? this.dataDetail);
  }

  @override
  List<Object> get props => [apiRequestStatus, dataDetail];
}
