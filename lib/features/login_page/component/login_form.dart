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

extension LoginForm on LoginPage {
  Widget buildLoginForm(
      BuildContext context, LoginState state, TextEditingController email, TextEditingController pass) {
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
              Text(
                translation(context).password,
                style: typoInterNomal16.copyWith(color: colorTextMedium),
              ),
              const SizedBox(
                height: 8,
              ),
              AppTextFormField(
                borderRadius: 10,
                obscureText: state.showPass,
                controller: pass,
                suffixIcon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: GestureDetector(
                            onTap: () {
                              BlocProvider.of<LoginCubit>(context).showPassword(!state.showPass);
                            },
                            child: SvgPicture.asset(
                                state.showPass ? R.ASSETS_SVG_EYE_LINE_SVG : R.ASSETS_SVG_EYE_OFF_LINE_SVG))),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.read<LoginCubit>().gotoFogot(true);
                    },
                    child: Text(
                      translation(context).forgot_pass,
                      style: typoInterNomal14.copyWith(color: colorBrandPrimary),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              AppElevatedButton(
                state: state.buttonState,
                onPressed: () {
                  context.read<LoginCubit>().loginRequest(context, email.text.trim(), pass.text.trim());
                },
                buttonTitle: translation(context).login,
              )
            ]));
  }
}
