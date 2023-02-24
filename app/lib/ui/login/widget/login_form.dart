import 'package:app/shared_view/app_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resources/resources.dart';
import '../../../app.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    required this.email,
    required this.pass,
    required this.bloc,
    super.key,
  });
  final TextEditingController email;
  final TextEditingController pass;
  final LoginBloc bloc;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          title: S.current.email,
          hintText: S.current.email,
          // obscureText: true,
          onChanged: (email) => bloc.add(EmailTextFieldChanged(email: email)),
          controller: email,
          keyboardType: TextInputType.visiblePassword,
        ),
        const SizedBox(
          height: 24,
        ),
        BlocBuilder<LoginBloc, LoginState>(
          bloc: bloc,
          buildWhen: (previous, current) => previous.obscureText != current.obscureText,
          builder: (context, state) {
            return AppTextField(
              title: S.current.password,
              hintText: S.current.password,
              obscureText: state.obscureText,
              onChanged: (pass) => bloc.add(PasswordTextFieldChanged(password: pass)),
              controller: pass,
              suffixIcon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: GestureDetector(
                      onTap: () {
                        // BlocProvider.of<LoginCubit>(context).showPassword(!state.showPass);
                        bloc.add(const EyeIconPressed());
                      },
                      child: SvgPicture.asset(state.obscureText ? Assets.svg.eyeLine.path : Assets.svg.eyeOffLine.path),
                    ),
                  ),
                ],
              ),
              keyboardType: TextInputType.visiblePassword,
            );
          },
        ),
        // Text(
        //   translation(context).password,
        //   style: typoInterNomal16.copyWith(color: colorTextMedium),
        // ),
        // const SizedBox(
        //   height: 8,
        // ),
        // AppTextFormField(
        //   borderRadius: 10,
        //   obscureText: state.showPass,
        //   controller: pass,
        //   suffixIcon: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Padding(
        //           padding: const EdgeInsets.symmetric(horizontal: 4),
        //           child: GestureDetector(
        //               onTap: () {
        //                 BlocProvider.of<LoginCubit>(context).showPassword(!state.showPass);
        //               },
        //               child: SvgPicture.asset(
        //                   state.showPass ? R.ASSETS_SVG_EYE_LINE_SVG : R.ASSETS_SVG_EYE_OFF_LINE_SVG))),
        //     ],
        //   ),
        // ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                bloc.add(const GotoView());
              },
              child: Text(
                S.current.forgot_pass,
                style: typoInterNomal14.copyWith(color: colorBrandPrimary),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        BlocBuilder<LoginBloc, LoginState>(
          bloc: bloc,
          buildWhen: (previous, current) => previous.buttonState != current.buttonState,
          builder: (context, state) {
            return AppElevatedButton(
              state: state.buttonState,
              onPressed: () {
                bloc.add(const LoginButtonPressed());
              },
              buttonTitle: S.current.login,
            );
          },
        ),
      ],
    );
  }
}
