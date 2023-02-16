import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project/core/di/dependency_injection.dart';
import 'package:project/core/utils/enum/api_request_status.dart';
import 'package:project/features/internal_app/model/notification_model.dart';

import '../../internal_app/data/repository/internal_app_repository.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(const NotificationState(notification: [], notificationUnread: []));
  final responsitory = getIt.get<InternalAppRepository>();
  final List<Notification> listDataNoti = [];
  final List<Notification> listDataNotiUnread = [];
  Future<void> requestNotification({int page = 1, int perPage = 15}) async {
    emit(state.coppyWith(
      notification: listDataNoti,
      apiRequestStatus: APIRequestStatus.loading,
      page: 1,
    ));
    try {
      final response = await responsitory.requestNotification(page, perPage);
      if (response.statusCode == 200) {
        if (response.data != null && response.data!.data != null && response.data!.data!.isNotEmpty) {
          for (var item in response.data!.data!) {
            // print(item.title);
            listDataNoti.add(item);
          }
          print(listDataNoti.length);

          if ((response.data?.currentPage ?? 1) == (response.data?.totalPage ?? 1)) {
            emit(state.coppyWith(
              notification: listDataNoti,
              apiRequestStatus: APIRequestStatus.loaded,
              page: response.data?.currentPage ?? 1,
            ));
          } else {
            emit(state.coppyWith(
              notification: listDataNoti,
              apiRequestStatus: APIRequestStatus.loaded,
              page: response.data?.currentPage ?? 1,
            ));
          }
        }
      } else {
        emit(state.coppyWith(
          notification: listDataNoti,
          apiRequestStatus: APIRequestStatus.nodata,
          page: response.data?.currentPage ?? 1,
        ));
      }
    } catch (e) {
      emit(state.coppyWith(
        notification: listDataNoti,
        apiRequestStatus: APIRequestStatus.error,
        page: 1,
      ));
    }
  }
}
