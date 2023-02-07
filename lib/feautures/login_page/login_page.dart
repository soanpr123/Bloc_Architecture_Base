import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/component/app_elevated_button.dart';
import 'package:project/component/app_text_form_field.dart';
import 'package:project/core/di/dependency_injection.dart';
import 'package:project/core/style/colors.dart';
import 'package:project/core/style/resource.dart';
import 'package:project/core/style/text_style.dart';
import 'package:project/core/utils/toast_message.dart';
import 'package:project/feautures/login_page/component/background-image.dart';
import 'package:project/feautures/login_page/cubit/login_cubit.dart';

// class LoginPage extends StatelessWidget {
//   const LoginPage({Key? key}) : super(key: key);

//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final emailCtrl = TextEditingController();
    final passwordCtrl = TextEditingController();
    return Stack(
      children: [
        const BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: BlocProvider(
            create: (context) => LoginCubit(),
            child: BlocListener<LoginCubit, LoginState>(
              listener: (context, state) {
                // TODO: implement listener
                if (state.message != "") {
                  errorToast(msg: state.message);
                } else {}
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    R.ASSETS_PNG_LOGO_PNG,
                    fit: BoxFit.contain,
                    width: 250,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    decoration:
                        const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
                    // height: MediaQuery.of(context).size.height / 2,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Email",
                            style: typoInterNomal16.copyWith(color: colorTextMedium),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          AppTextFormField(
                            controller: emailCtrl,
                            borderRadius: 10,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            "Mật khẩu",
                            style: typoInterNomal16.copyWith(color: colorTextMedium),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          BlocBuilder<LoginCubit, LoginState>(
                            buildWhen: (previous, current) => previous.showPass != current.showPass,
                            builder: (context, states) {
                              return AppTextFormField(
                                borderRadius: 10,
                                obscureText: states.showPass,
                                controller: passwordCtrl,
                                suffixIcon: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 4),
                                        child: GestureDetector(
                                            onTap: () {
                                              context.read<LoginCubit>().showPassword(!states.showPass);
                                            },
                                            child: states.showPass
                                                ? SvgPicture.asset(R.ASSETS_SVG_EYE_OFF_LINE_SVG)
                                                : SvgPicture.asset(R.ASSETS_SVG_EYE_LINE_SVG))),
                                  ],
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Quên mật khẩu",
                                style: typoInterNomal14.copyWith(color: colorBrandPrimary),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          BlocBuilder<LoginCubit, LoginState>(
                            buildWhen: (pre, current) => pre.buttonState != current.buttonState,
                            builder: (context, state1) {
                              return AppElevatedButton(
                                state: state1.buttonState,
                                onPressed: () {
                                  context
                                      .read<LoginCubit>()
                                      .loginRequest(emailCtrl.text.trim(), passwordCtrl.text.trim());
                                },
                                buttonTitle: "Đăng nhập",
                              );
                            },
                          ),
                        ]),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
