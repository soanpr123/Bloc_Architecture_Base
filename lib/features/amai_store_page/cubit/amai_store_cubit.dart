import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:project/component/app_elevated_button.dart';
import 'package:project/core/di/dependency_injection.dart';
import 'package:project/core/utils/enum/api_request_status.dart';
import 'package:project/core/utils/toast_message.dart';
import 'package:project/features/internal_app/model/order_menu_model.dart';
import 'package:project/features/internal_app/model/orderd_model.dart';

import '../../internal_app/data/repository/internal_app_repository.dart';

part 'amai_store_state.dart';

class AmaiStoreCubit extends Cubit<AmaiStoreState> {
  AmaiStoreCubit()
      : super(AmaiStoreState(
            apiRequestStatus: APIRequestStatus.loading,
            listCanteen: [],
            listOther: [],
            // buttonStateOrderList: [],
            buttonState: AppElevatedButtonState.active,
            ordered: DataOrdered()));

  final responsitory = getIt.get<InternalAppRepository>();

  Future<void> requestMenu(BuildContext context) async {
    emit(state.coppyWith(listCanteen: [], listOther: [], apiRequestStatus: APIRequestStatus.loading));

    try {
      final response = await responsitory.requestOrderMenu();
      if (response.statusCode == 200) {
        if (response.data != null) {
          if (response.data!.canteen != null && response.data!.canteen!.isNotEmpty ||
              response.data!.other != null && response.data!.other!.isNotEmpty) {
            emit(state.coppyWith(
                listCanteen: response.data?.canteen ?? [],
                listOther: response.data?.other ?? [],
                apiRequestStatus: APIRequestStatus.loaded,
                buttonState: AppElevatedButtonState.active));
            await getOrdered();
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

  Future<void> orderStore(
    int id,
  ) async {
    final request = {
      "lunch_menus_id": id,
    };
    emit(state.coppyWith(buttonState: AppElevatedButtonState.loading));
    try {
      final response = await responsitory.orderStore(request);
      if (response.data['status_code'] == 200 && response.data['data'] == true) {
        successToast(response.data['message']);
        await getOrdered();
        emit(state.coppyWith(buttonState: AppElevatedButtonState.active));
      } else {
        errorToast(msg: response.data['message']);
        emit(state.coppyWith(buttonState: AppElevatedButtonState.active));
      }
    } catch (e) {
      emit(state.coppyWith(buttonState: AppElevatedButtonState.active));
    }
  }

  Future<void> getOrdered() async {
    final response = await responsitory.ordered();
    if (response.statusCode == 200 && response.data != null) {
      emit(state.coppyWith(ordered: response.data));
    } else {
      emit(state.coppyWith(ordered: DataOrdered()));
    }
  }

  Future<void> deteteOrdered() async {
    final response = await responsitory.deleteStore();
    if (response.data['status_code'] == 200 && response.data['data'] == true) {
      successToast(response.data['message']);
      await getOrdered();
    } else {
      errorToast(msg: response.data['message']);
    }
  }
}
