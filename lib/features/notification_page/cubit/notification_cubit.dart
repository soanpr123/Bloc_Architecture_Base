import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project/core/di/dependency_injection.dart';
import 'package:project/core/routers/router.dart';
import 'package:project/core/utils/enum/api_request_status.dart';
import 'package:project/features/home_page/cubit/home_page_cubit.dart';
import 'package:project/features/internal_app/model/notification_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../internal_app/data/repository/internal_app_repository.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(const NotificationState(notification: [], notificationUnread: []));
  final responsitory = getIt.get<InternalAppRepository>();
  final List<Notification> listDataNoti = [];
  final List<Notification> listDataNotiUnread = [];

  void onLoadingPage(RefreshController refreshController) async {
    emit(state.coppyWith(onReloadNotifi: true, page: state.page + 1));
    await requestNotification(page: state.page, perPage: 15);
    refreshController.loadComplete();
  }

  void onRefesPage(RefreshController refreshController) async {
    listDataNoti.clear();
    emit(state.coppyWith(onReloadNotifi: false, page: 1, notification: [], enablePullNotifi: true));
    await requestNotification(page: state.page, perPage: 15);
    refreshController.refreshCompleted();
  }

  void onLoadingPageUnread(RefreshController refreshController) async {
    emit(state.coppyWith(onReloadUnread: true, pageUnread: state.page + 1));
    await requestNotificationUnread(page: state.pageUnread, perPage: 15);
    refreshController.loadComplete();
  }

  void onRefesPageUnread(RefreshController refreshController) async {
    listDataNotiUnread.clear();
    emit(state.coppyWith(
        onReloadUnread: false,
        pageUnread: 1,
        notificationUnread: [],
        enablePullUnread: true,
        apiRequestStatusUnread: APIRequestStatus.loading));
    await requestNotificationUnread(page: state.pageUnread, perPage: 15);
    refreshController.refreshCompleted();
  }

  Future<void> requestNotification({int page = 1, int perPage = 15}) async {
    if (state.onReloadNotifi == true) {
      emit(state.coppyWith(
        notification: state.notification,
        apiRequestStatus: APIRequestStatus.loaded,
        page: 1,
      ));
    } else {
      emit(state.coppyWith(
        notification: [],
        apiRequestStatus: APIRequestStatus.loading,
        page: 1,
      ));
    }

    try {
      final response = await responsitory.requestNotification(page, perPage);
      if (response.statusCode == 200) {
        if (response.data != null && response.data!.data != null && response.data!.data!.isNotEmpty) {
          for (var item in response.data!.data!) {
            // print(item.title);
            listDataNoti.add(item);
          }
          // print(listDataNoti.length);

          if ((response.data?.currentPage ?? 1) == (response.data?.totalPage ?? 1)) {
            emit(state.coppyWith(
                notification: listDataNoti,
                apiRequestStatus: APIRequestStatus.loaded,
                page: response.data?.currentPage ?? 1,
                onReloadNotifi: false,
                enablePullNotifi: false));
          } else {
            emit(state.coppyWith(
                notification: listDataNoti,
                apiRequestStatus: APIRequestStatus.loaded,
                page: response.data?.currentPage ?? 1,
                onReloadNotifi: false,
                enablePullNotifi: true));
          }
        } else {
          emit(state.coppyWith(
              notification: listDataNoti,
              apiRequestStatus: APIRequestStatus.nodata,
              page: response.data?.currentPage ?? 1,
              onReloadNotifi: false,
              enablePullNotifi: true));
        }
      } else {
        emit(state.coppyWith(
          notification: listDataNoti,
          apiRequestStatus: APIRequestStatus.nodata,
          page: response.data?.currentPage ?? 1,
          onReloadNotifi: false,
        ));
      }
    } catch (e) {
      print(e);
      emit(state.coppyWith(
        notification: listDataNoti,
        apiRequestStatus: APIRequestStatus.error,
        page: 1,
        onReloadNotifi: false,
      ));
    }
  }

  Future<void> requestNotificationUnread({int page = 1, int perPage = 15}) async {
    // print(state.onReloadUnread);
    if (state.onReloadUnread == true) {
      emit(state.coppyWith(
        notificationUnread: state.notificationUnread,
        apiRequestStatusUnread: APIRequestStatus.loaded,
        pageUnread: 1,
      ));
    } else {
      emit(state.coppyWith(
        notificationUnread: [],
        apiRequestStatusUnread: APIRequestStatus.loading,
        pageUnread: 1,
      ));
    }

    try {
      final response = await responsitory.requestNotificationUnread(page, perPage);
      if (response.statusCode == 200) {
        if (response.data != null && response.data!.data != null && response.data!.data!.isNotEmpty) {
          for (var item in response.data!.data!) {
            // print(item.title);
            listDataNotiUnread.add(item);
          }
          print(listDataNotiUnread.length);

          if ((response.data?.currentPage ?? 1) == (response.data?.totalPage ?? 1)) {
            emit(state.coppyWith(
                notificationUnread: listDataNotiUnread,
                apiRequestStatusUnread: APIRequestStatus.loaded,
                pageUnread: response.data?.currentPage ?? 1,
                onReloadUnread: false,
                enablePullUnread: false));
          } else {
            emit(state.coppyWith(
                notificationUnread: listDataNotiUnread,
                apiRequestStatusUnread: APIRequestStatus.loaded,
                pageUnread: response.data?.currentPage ?? 1,
                onReloadUnread: false,
                enablePullUnread: true));
          }
        } else {
          emit(state.coppyWith(
              notificationUnread: listDataNotiUnread,
              apiRequestStatusUnread: APIRequestStatus.nodata,
              pageUnread: response.data?.currentPage ?? 1,
              onReloadUnread: false,
              enablePullUnread: true));
        }
      } else {
        emit(state.coppyWith(
          notificationUnread: listDataNotiUnread,
          apiRequestStatusUnread: APIRequestStatus.nodata,
          pageUnread: response.data?.currentPage ?? 1,
          onReloadUnread: false,
        ));
      }
    } catch (e) {
      emit(state.coppyWith(
        notificationUnread: listDataNotiUnread,
        apiRequestStatusUnread: APIRequestStatus.error,
        pageUnread: 1,
        onReloadUnread: false,
      ));
    }
  }

  Future onTapNotifi(String type, String slung, String id) async {
    await responsitory.showNotification(id);
    if (type == "announcements") {
      AppRouter().push(AnnouncementDetailRoute(slug: slung, useCase: "home"));
    } else if (type == "lunch_menus") {
      AppRouter().push(AmaiStoreRoute());
    }
    getIt<HomePageCubit>().requestTotalUnread();
    listDataNoti.clear();
    emit(state.coppyWith(onReloadNotifi: false, page: 1, notification: [], enablePullNotifi: true));
    await requestNotification(page: state.page, perPage: 15);
    listDataNotiUnread.clear();
    emit(state.coppyWith(
        onReloadUnread: false,
        pageUnread: 1,
        notificationUnread: [],
        enablePullUnread: true,
        apiRequestStatusUnread: APIRequestStatus.loading));
    await requestNotificationUnread(page: state.pageUnread, perPage: 15);
  }
}
