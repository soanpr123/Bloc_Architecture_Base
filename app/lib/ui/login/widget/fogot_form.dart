import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

import '../../../app.dart';

class ForgotForm extends StatelessWidget {
  const ForgotForm({
    required this.bloc,
    required this.email,
    super.key,
  });
  final LoginBloc bloc;
  final TextEditingController email;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          title: S.current.email,
          hintText: S.current.email,
          // obscureText: true,?
          onChanged: (email) => bloc.add(EmailTextFieldChangedForgot(email: email)),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(
          height: 24,
        ),
        BlocBuilder<LoginBloc, LoginState>(
          bloc: bloc,
          buildWhen: (previous, current) => previous.buttonStateForgot != current.buttonStateForgot,
          builder: (context, state) {
            return AppElevatedButton(
              state: state.buttonStateForgot,
              onPressed: () =>bloc.add(const ForgotButtonPressed()),
              buttonTitle: S.current.confirm,
            );
          },
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                bloc.add(const GotoView());
              },
              child: Text(
                S.current.back_to_login,
                style: typoInterNomal14.copyWith(color: colorBrandPrimary),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
