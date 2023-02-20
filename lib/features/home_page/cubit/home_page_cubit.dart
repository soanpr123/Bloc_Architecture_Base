import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project/core/di/dependency_injection.dart';
import 'package:project/core/utils/enum/api_request_status.dart';
import 'package:project/features/internal_app/model/announcement_model.dart';
import 'package:project/features/internal_app/model/profile_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:weather/weather.dart';

import '../../internal_app/data/repository/internal_app_repository.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit()
      : super(HomePageState(
            profile: DataProfile(), notifyCationLocalStatus: APIRequestStatus.nodata, announcementData: []));
  final responsitory = getIt.get<InternalAppRepository>();
  final List<AnnouncementData> listData = [];

  Future queryWeather(WeatherFactory ws) async {
    Weather weather = await ws.currentWeatherByCityName("HaNoi");
    emit(state.coppyWith(temp: (weather.temperature?.celsius ?? 0).ceilToDouble()));
  }

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

  Future<void> requestNotifycationLocal({int page = 1, int perpage = 5}) async {
    emit(state.coppyWith(announcementData: [], notifyCationLocalStatus: APIRequestStatus.loading));

    try {
      final response = await responsitory.requestAnnouncement(page, perpage);
      if (response.statusCode == 200) {
        if (response.data != null && response.data!.data != null && response.data!.data!.isNotEmpty) {
          emit(state.coppyWith(
            announcementData: response.data!.data!,
            notifyCationLocalStatus: APIRequestStatus.loaded,
          ));
        } else {
          emit(state.coppyWith(
            announcementData: response.data!.data!,
            notifyCationLocalStatus: APIRequestStatus.nodata,
          ));
        }
      } else {
        emit(state.coppyWith(
          announcementData: [],
          notifyCationLocalStatus: APIRequestStatus.nodata,
        ));
      }
    } catch (e) {
      emit(state.coppyWith(
        announcementData: [],
        notifyCationLocalStatus: APIRequestStatus.nodata,
      ));
    }
  }

  Future<void> requestTotalUnread() async {
    try {
      final response = await responsitory.getTotalUnread();
      if (response.data['status_code'] == 200) {
        emit(state.coppyWith(totalUnread: int.parse(response.data['data']['total_unread'].toString())));
      } else {
        emit(state.coppyWith(totalUnread: 0));
      }
    } catch (e) {
      emit(state.coppyWith(totalUnread: 0));
    }
  }
}
