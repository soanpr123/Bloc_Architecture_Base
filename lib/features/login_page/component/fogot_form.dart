part of '../login_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:project/component/app_elevated_button.dart';
// import 'package:project/component/app_text_form_field.dart';
// import 'package:project/core/style/colors.dart';
// import 'package:project/core/style/resource.dart';
// import 'package:project/core/style/text_style.dart';
// import 'package:project/features/login_page/cubit/login_cubit.dart';
// import 'package:project/features/login_page/login_page.dart';

// class LoginForm extends StatelessWidget {
//   final LoginState state;
//   LoginForm({Key? key, required this.state}) : super(key: key);
//   final emailCtrl = TextEditingController();
//   final passwordCtrl = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return;
//   }
// }

extension ForgotForm on LoginPage {
  Widget buildFogotForm(
    BuildContext context,
    LoginState state,
    TextEditingController email,
  ) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
        // height: MediaQuery.of(context).size.height / 2,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                translation(context).email,
                style: typoInterNomal16.copyWith(color: colorTextMedium),
              ),
              const SizedBox(
                height: 8,
              ),
              AppTextFormField(
                controller: email,
                borderRadius: 10,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 24,
              ),
              AppElevatedButton(
                state: state.buttonState,
                onPressed: () {
                  context.read<LoginCubit>().forgetRequest(email.text.trim(), context);
                },
                buttonTitle: translation(context).confirm,
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.read<LoginCubit>().gotoFogot(false);
                    },
                    child: Text(
                      translation(context).back_to_login,
                      style: typoInterNomal14.copyWith(color: colorBrandPrimary),
                    ),
                  ),
                ],
              ),
            ]));
  }
}
