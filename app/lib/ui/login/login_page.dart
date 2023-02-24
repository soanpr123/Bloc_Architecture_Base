import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

import '../../app.dart';
import 'widget/fogot_form.dart';
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
          padding: const EdgeInsets.all(Dimens.d16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Assets.png.imgLogoBlack.path,
                fit: BoxFit.contain,
                width: Dimens.d250.responsive(),
              ),
              SizedBox(
                height: Dimens.d72.responsive(),
              ),
              Text(
                S.current.login,
                style: typoInterNomal18.copyWith(fontSize: 24, color: colorTextDark),
              ),
              SizedBox(
                height: Dimens.d24.responsive(),
              ),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return state.showView
                      ? ForgotForm(
                          bloc: bloc,
                          email: emailCtrl,
                        )
                      : LoginForm(email: emailCtrl, pass: passwordCtrl, bloc: bloc);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
