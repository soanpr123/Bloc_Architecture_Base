import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project/core/di/dependency_injection.dart';
import 'package:project/core/utils/enum/api_request_status.dart';
import 'package:project/features/home_page/cubit/home_page_cubit.dart';
import 'package:project/features/internal_app/data/repository/internal_app_repository.dart';
import 'package:project/features/internal_app/model/announcement_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'announcement_state.dart';

class AnnouncementCubit extends Cubit<AnnouncementState> {
  AnnouncementCubit()
      : super(const AnnouncementState(
          announcementData: [],
          notifyCationLocalStatus: APIRequestStatus.nodata,
        ));
  final responsitory = getIt.get<InternalAppRepository>();
  final List<AnnouncementData> listData = [];
  final bloc = getIt<HomePageCubit>();
  void onLoadingPage(RefreshController refreshController) async {
    emit(state.coppyWith(onReload: true, page: state.page + 1));
    await requestNotifycationLocal(page: state.page, perpage: 15);
    refreshController.loadComplete();
  }

  void onRefesPage(RefreshController refreshController) async {
    listData.clear();
    emit(state.coppyWith(onReload: false, page: 1, announcementData: [], enablePull: true));
    await requestNotifycationLocal(page: state.page, perpage: 15);
    refreshController.refreshCompleted();
  }

  void onReload() async {
    listData.clear();
    emit(state.coppyWith(onReload: false, page: 1, announcementData: [], enablePull: true));
    await requestNotifycationLocal(page: state.page, perpage: 15);
  }

  Future<void> requestNotifycationLocal({int page = 1, int perpage = 5}) async {
    if (state.onReload == true) {
      emit(state.coppyWith(announcementData: state.announcementData, notifyCationLocalStatus: APIRequestStatus.loaded));
    } else {
      emit(state.coppyWith(announcementData: [], notifyCationLocalStatus: APIRequestStatus.loading));
    }

    try {
      final response = await responsitory.requestAnnouncement(page, perpage);
      if (response.statusCode == 200) {
        if (response.data != null && response.data!.data != null && response.data!.data!.isNotEmpty) {
          for (var item in response.data!.data!) {
            // print(item.title);
            listData.add(item);
          }
          print(listData.length);

          if ((response.data?.currentPage ?? 1) == (response.data?.totalPage ?? 1)) {
            emit(state.coppyWith(
                announcementData: listData,
                notifyCationLocalStatus: APIRequestStatus.loaded,
                page: response.data?.currentPage ?? 1,
                onReload: false,
                enablePull: false));
          } else {
            emit(state.coppyWith(
                announcementData: listData,
                notifyCationLocalStatus: APIRequestStatus.loaded,
                page: response.data?.currentPage ?? 1,
                onReload: false,
                enablePull: true));
          }
        } else {
          emit(state.coppyWith(
              announcementData: response.data!.data!,
              notifyCationLocalStatus: APIRequestStatus.nodata,
              page: response.data?.currentPage ?? 1,
              onReload: false));
        }
      } else {
        emit(state.coppyWith(
            announcementData: [],
            notifyCationLocalStatus: APIRequestStatus.nodata,
            page: response.data?.currentPage ?? 1,
            onReload: false));
      }
    } catch (e) {
      emit(state.coppyWith(announcementData: [], notifyCationLocalStatus: APIRequestStatus.nodata, onReload: false));
    }
  }
}
