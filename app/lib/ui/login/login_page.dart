import 'package:flutter/material.dart';

import 'package:resources/resources.dart';

import '../../app.dart';

import 'widget/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BasePageState<LoginPage, LoginBloc> {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: Dimens.d16.responsive()),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: Dimens.d128.responsive(),
              ),
              Image.asset(
                Assets.png.imgLogoBlack.path,
                fit: BoxFit.contain,
                width: Dimens.d188.responsive(),
                height: Dimens.d64.responsive(),
              ),
              SizedBox(
                height: Dimens.d72.responsive(),
              ),
              Text(
                S.current.login,
                style: typoInterNomal18.copyWith(
                  fontSize: Dimens.d24.responsive(),
                  fontWeight: FontWeight.w700,
                  color: colorTextDark,
                ),
              ),
              SizedBox(
                height: Dimens.d24.responsive(),
              ),
              // BlocBuilder<LoginBloc, LoginState>(
              //   builder: (context, state) {
              //     return state.showView
              //         ? ForgotForm(
              //             bloc: bloc,
              //             email: emailCtrl,
              //           )
              //         :
              //   },
              // ),
              LoginForm(email: emailCtrl, pass: passwordCtrl, bloc: bloc),
            ],
          ),
        ),
      ),
    );
  }
}
