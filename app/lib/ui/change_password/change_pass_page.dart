import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

import '../../app.dart';

class ChangePassPage extends StatefulWidget {
  const ChangePassPage({Key? key}) : super(key: key);

  @override
  _ChangePassPageState createState() => _ChangePassPageState();
}

class _ChangePassPageState extends BasePageState<ChangePassPage, ChangePassBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        centerTitle: true,
        elevation: 1,
        title: Text(
          S.current.change_password,
          style: typoInterNomal18,
        ),
      ),
      body: BlocBuilder<ChangePassBloc, ChangePassState>(
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    formText(
                      S.current.current_pass,
                      state.showCurrentPass,
                      onTap: () {
                        bloc.add(ShowPassPress(showCurr: !state.showCurrentPass));
                      },
                      onChanged: (v) {
                        // print(v);
                        bloc.add(ChangePassTextInput(currentPass: v));
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    formText(
                      S.current.new_pass,
                      state.showNewPass,
                      onTap: () {
                        bloc.add(ShowNewPassPress(showNew: !state.showNewPass));
                      },
                      onChanged: (v) {
                        bloc.add(ChangeNewPassTextInput(newPass: v));
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    formText(
                      S.current.confirm_new_pass,
                      state.showConfirmPass,
                      onTap: () {
                        bloc.add(ShowConfiPassPress(showConf: !state.showConfirmPass));
                      },
                      onChanged: (v) {
                        bloc.add(ChangeConfirmPassTextInput(confirmPass: v));
                      },
                    ),
                  ],
                ),
                AppElevatedButton(
                  onPressed: () {
                    bloc.add(const ChangePassPress());
                  },
                  buttonTitle: S.current.confirm,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Column formText(String title, bool show, {GestureTapCallback? onTap, Function(String)? onChanged}) {
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
          onChanged: onChanged,
          suffixIcon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: GestureDetector(
                  onTap: onTap,
                  child: show
                      ? Assets.svg.eyeLine.svg(width: 24, height: 24)
                      : Assets.svg.eyeOffLine.svg(width: 24, height: 24),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
