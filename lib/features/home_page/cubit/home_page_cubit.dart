import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project/core/di/dependency_injection.dart';
import 'package:project/core/utils/enum/api_request_status.dart';
import 'package:project/features/internal_app/model/announcement_model.dart';
import 'package:project/features/internal_app/model/profile_model.dart';

import '../../internal_app/data/repository/internal_app_repository.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit()
      : super(HomePageState(
            profile: DataProfile(), notifyCationLocalStatus: APIRequestStatus.nodata, announcementData: []));
  final responsitory = getIt.get<InternalAppRepository>();
  Future<void> getProfile() async {
    try {
      final response = await responsitory.requestMe();
      if (response.statusCode == 200) {
        emit(state.coppyWith(profile: response.data));
      } else {
        emit(state.coppyWith(profile: DataProfile()));
      }
    } catch (e) {
      emit(state.coppyWith(profile: DataProfile()));
    }
  }

  Future<void> requestNotifycationLocal() async {
    emit(state.coppyWith(announcementData: [], notifyCationLocalStatus: APIRequestStatus.loading));
    try {
      final response = await responsitory.requestAnnouncement(1, 5);
      if (response.statusCode == 200) {
        if (response.data != null && response.data!.data != null && response.data!.data!.isNotEmpty) {
          emit(state.coppyWith(
              announcementData: response.data!.data!, notifyCationLocalStatus: APIRequestStatus.loaded));
        } else {
          emit(state.coppyWith(
              announcementData: response.data!.data!, notifyCationLocalStatus: APIRequestStatus.nodata));
        }
      } else {
        emit(state.coppyWith(announcementData: [], notifyCationLocalStatus: APIRequestStatus.nodata));
      }
    } catch (e) {
      emit(state.coppyWith(announcementData: [], notifyCationLocalStatus: APIRequestStatus.nodata));
    }
  }
}
