import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/component/app_elevated_button.dart';
import 'package:project/component/custom_alert.dart';
import 'package:project/core/style/colors.dart';
import 'package:project/core/style/text_style.dart';
import 'package:project/core/style/transaction.dart';
import 'package:project/features/amai_store_page/cubit/amai_store_cubit.dart';
import 'package:project/features/internal_app/model/order_menu_model.dart';
import 'package:project/features/profile_page/cubit/profile_cubit.dart';

class DialogLogout extends StatelessWidget {
  const DialogLogout({Key? key, required this.state, required this.bloc}) : super(key: key);
  final ProfileState state;
  final ProfileCubit bloc;
  @override
  Widget build(BuildContext context) {
    return CustomAlert(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(children: [
          Text(
            translation(context).tell_me_logout,
            textAlign: TextAlign.center,
            style: typoInterNomal16,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                child: AppElevatedButton(
                  mainColor: colorBrandSecondary,
                  onPressed: () {
                    Navigator.pop(context);
                    // gotoFogot(false);
                  },
                  buttonTitle: translation(context).cancel,
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Expanded(
                child: BlocBuilder<ProfileCubit, ProfileState>(
                  bloc: bloc,
                  builder: (context, state) {
                    return AppElevatedButton(
                      state: state.requestLogout,
                      onPressed: () async {
                        await bloc.logOut(context);
                      },
                      buttonTitle: translation(context).confirm,
                    );
                  },
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}

class DialogConfirmOrder extends StatelessWidget {
  const DialogConfirmOrder({Key? key, required this.state, required this.bloc, required this.id, required this.name})
      : super(key: key);
  final AmaiStoreState state;
  final AmaiStoreCubit bloc;
  final int id;
  final String name;
  @override
  Widget build(BuildContext context) {
    return CustomAlert(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(children: [
          Text(
            translation(context).confirm_order(name),
            textAlign: TextAlign.center,
            style: typoInterNomal16,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                child: AppElevatedButton(
                  mainColor: colorBrandSecondary,
                  onPressed: () {
                    Navigator.pop(context);
                    // gotoFogot(false);
                  },
                  buttonTitle: translation(context).cancel,
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Expanded(
                child: BlocBuilder<AmaiStoreCubit, AmaiStoreState>(
                  bloc: bloc,
                  builder: (_, state) {
                    return AppElevatedButton(
                      state: state.buttonState,
                      onPressed: () async {
                        await bloc.orderStore(id);
                        Navigator.pop(context);
                      },
                      buttonTitle: translation(context).confirm,
                    );
                  },
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
