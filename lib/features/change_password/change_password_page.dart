import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/component/app_elevated_button.dart';
import 'package:project/component/app_text_form_field.dart';
import 'package:project/core/style/colors.dart';
import 'package:project/core/style/resource.dart';
import 'package:project/core/style/text_style.dart';
import 'package:project/core/style/transaction.dart';
import 'package:project/features/change_password/cubit/change_password_cubit.dart';

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({Key? key}) : super(key: key);
  final currentPassCtrl = TextEditingController();
  final newPassCtrl = TextEditingController();
  final confirmNewPassCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        centerTitle: true,
        elevation: 1,
        title: Text(
          translation(context).change_password,
          style: typoInterNomal18,
        ),
      ),
      body: BlocProvider(
        create: (context) => ChangePasswordCubit(),
        child: BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
          builder: (context, state) {
            return Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      formText(translation(context).current_pass, currentPassCtrl, state.showCurrentPass, onTap: () {
                        context.read<ChangePasswordCubit>().showCurrentPass(!state.showCurrentPass);
                      }, onChanged: (v) {
                        // print(v);
                        context.read<ChangePasswordCubit>().checkLength(
                            currentPassCtrl.text.trim(), newPassCtrl.text.trim(), confirmNewPassCtrl.text.trim());
                      }),
                      const SizedBox(
                        height: 8,
                      ),
                      formText(translation(context).new_pass, newPassCtrl, state.showNewPass, onTap: () {
                        context.read<ChangePasswordCubit>().showNewPass(!state.showNewPass);
                      }, onChanged: (v) {
                        context.read<ChangePasswordCubit>().checkLength(
                            currentPassCtrl.text.trim(), newPassCtrl.text.trim(), confirmNewPassCtrl.text.trim());
                      }),
                      const SizedBox(
                        height: 8,
                      ),
                      formText(translation(context).confirm_new_pass, confirmNewPassCtrl, state.showConfirmPass,
                          onTap: () {
                        context.read<ChangePasswordCubit>().showConfirmPass(!state.showConfirmPass);
                      }, onChanged: (v) {
                        context.read<ChangePasswordCubit>().checkLength(
                            currentPassCtrl.text.trim(), newPassCtrl.text.trim(), confirmNewPassCtrl.text.trim());
                      }),
                    ],
                  ),
                  AppElevatedButton(
                    state: state.buttonState,
                    onPressed: () {
                      context.read<ChangePasswordCubit>().changePassWord(currentPassCtrl.text.trim(),
                          newPassCtrl.text.trim(), confirmNewPassCtrl.text.trim(), context);
                    },
                    buttonTitle: translation(context).confirm,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Column formText(String title, TextEditingController controller, bool show,
      {GestureTapCallback? onTap, Function(String)? onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: typoInterNomal16.copyWith(color: colorTextMedium),
        ),
        const SizedBox(
          height: 8,
        ),
        AppTextFormField(
          borderRadius: 5,
          obscureText: show,
          controller: controller,
          onChanged: onChanged,
          suffixIcon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: GestureDetector(
                      onTap: onTap,
                      child: SvgPicture.asset(show ? R.ASSETS_SVG_EYE_LINE_SVG : R.ASSETS_SVG_EYE_OFF_LINE_SVG))),
            ],
          ),
        ),
      ],
    );
  }
}
