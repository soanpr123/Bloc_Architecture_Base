import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:project/core/di/dependency_injection.dart';
import 'package:project/core/utils/enum/api_request_status.dart';
import 'package:project/features/internal_app/model/order_menu_model.dart';

import '../../internal_app/data/repository/internal_app_repository.dart';

part 'amai_store_state.dart';

class AmaiStoreCubit extends Cubit<AmaiStoreState> {
  AmaiStoreCubit()
      : super(const AmaiStoreState(apiRequestStatus: APIRequestStatus.loading, listCanteen: [], listOther: []));

  final responsitory = getIt.get<InternalAppRepository>();

  Future<void> requestMenu(BuildContext context) async {
    try {
      final response = await responsitory.requestOrderMenu();
      if (response.statusCode == 200) {
        if (response.data != null) {
          if (response.data!.canteen != null || response.data!.other != null) {
            emit(state.coppyWith(
                listCanteen: response.data?.canteen ?? [],
                listOther: response.data?.other ?? [],
                apiRequestStatus: APIRequestStatus.loaded));
          } else {
            emit(state.coppyWith(listCanteen: [], listOther: [], apiRequestStatus: APIRequestStatus.storenodata));
          }
        } else {
          emit(state.coppyWith(listCanteen: [], listOther: [], apiRequestStatus: APIRequestStatus.storenodata));
        }
      } else {
        emit(state.coppyWith(listCanteen: [], listOther: [], apiRequestStatus: APIRequestStatus.storenodata));
      }
    } catch (e) {
      emit(state.coppyWith(listCanteen: [], listOther: [], apiRequestStatus: APIRequestStatus.error));
    }
  }
}
