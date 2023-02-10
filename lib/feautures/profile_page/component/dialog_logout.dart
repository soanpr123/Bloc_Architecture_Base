import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/component/app_elevated_button.dart';
import 'package:project/component/custom_alert.dart';
import 'package:project/core/style/colors.dart';
import 'package:project/core/style/text_style.dart';
import 'package:project/core/style/transaction.dart';
import 'package:project/feautures/profile_page/cubit/profile_cubit.dart';

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
