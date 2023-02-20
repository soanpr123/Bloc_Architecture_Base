import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:project/component/app_elevated_button.dart';
import 'package:project/core/di/dependency_injection.dart';
import 'package:project/core/routers/router.dart';
import 'package:project/core/style/transaction.dart';
import 'package:project/core/utils/toast_message.dart';
import 'package:project/features/home_page/cubit/home_page_cubit.dart';
import 'package:project/features/internal_app/data/repository/internal_app_repository.dart';
import 'package:project/features/profile_page/component/dialog.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(const PaymentState());
  final responsitory = getIt.get<InternalAppRepository>();


  

  Future payment(String amai, String content, BuildContext context) async {
    emit(state.addState(buttonState: AppElevatedButtonState.loading));

    if (amai.isEmpty) {
      errorToast(msg: "Vui lòng nhập số amai");
      emit(state.addState(buttonState: AppElevatedButtonState.active));
      return;
    }
    final request = {"amount_amais": amai, "note": content};
    try {
      final response = await responsitory.paymentAmai(request);

      if (response.data['status_code'] == 200) {
        emit(state.addState(buttonState: AppElevatedButtonState.active));
        getIt<HomePageCubit>().getProfile();
        showDialog(
            context: (context),
            barrierDismissible: false,
            builder: (co) {
              return DialogConfirm(
                title: response.data['message'],
                onTap: () {
                  var count = 0;
                  AppRouter().popUntil((route) => count++ == 3);
                },
              );
            });
      } else {
        emit(state.addState(buttonState: AppElevatedButtonState.active));
        errorToast(msg: response.data['message']);
      }
    } catch (e) {
      emit(state.addState(buttonState: AppElevatedButtonState.active));
    }
  }
}
