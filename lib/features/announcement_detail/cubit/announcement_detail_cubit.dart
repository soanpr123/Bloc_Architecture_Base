import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/core/di/dependency_injection.dart';
import 'package:project/core/utils/enum/api_request_status.dart';
import 'package:project/features/internal_app/model/announcement_detail_model.dart';

import '../../internal_app/data/repository/internal_app_repository.dart';

part 'announcement_detail_state.dart';

class AnnouncementDetailCubit extends Cubit<AnnouncementDetailState> {
  AnnouncementDetailCubit() : super(AnnouncementDetailState(dataDetail: DataDetail()));
  final responsitory = getIt.get<InternalAppRepository>();

  Future<void> requestReadAnnouncement(String slung, BuildContext context) async {
    emit(state.coppyWith(dataDetail: DataDetail(), apiRequestStatus: APIRequestStatus.loading));

    try {
      final response = await responsitory.requestReadAnnouncement(slung);
      if (response.statusCode == 200) {
        if (response.data != null) {
          // AnnouncementCubit().checkUserReadNoti(slung);
          await checkUserReadNoti(slung);
          emit(state.coppyWith(dataDetail: response.data, apiRequestStatus: APIRequestStatus.loaded));
        } else {
          emit(state.coppyWith(dataDetail: DataDetail(), apiRequestStatus: APIRequestStatus.nodata));
        }
      } else {
        emit(state.coppyWith(dataDetail: DataDetail(), apiRequestStatus: APIRequestStatus.nodata));
      }
    } catch (e) {
      emit(state.coppyWith(dataDetail: DataDetail(), apiRequestStatus: APIRequestStatus.error));
    }
  }

  Future<void> checkUserReadNoti(
    String slugs,
  ) async {
    final response = await responsitory.checkUsertReadAnnouncement(slugs);
    if (response.data['status_code'] == 200) {
      // await bloc.checkUserReadNoti(slugs);
    }
  }
}
