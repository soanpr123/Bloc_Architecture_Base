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
      appBar: CommonAppBar(
        leadingIcon: const BackButton(color: Colors.white),
        corlorText: Colors.white,
        backgroundColor: colorBrandPrimary,
        centerTitle: true,
        elevation: 1,
        text: S.current.change_password,
      ),
      body: BlocBuilder<ChangePassBloc, ChangePassState>(
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    formText(
                      S.current.current_pass,
                      state.showCurrentPass,
                      errrText: state.showErrPass == '' ? null : state.showErrPass,
                      onTap: () {
                        bloc.add(ShowPassPress(showCurr: !state.showCurrentPass));
                      },
                      onChanged: (v) {
                        // print(v);
                        bloc.add(ChangePassTextInput(currentPass: v));
                      },
                    ),
                    SizedBox(
                      height: Dimens.d12.responsive(),
                    ),
                    formText(
                      S.current.new_pass,
                      state.showNewPass,
                      errrText: state.showErrNewPass == '' ? null : state.showErrNewPass,
                      onTap: () {
                        bloc.add(ShowNewPassPress(showNew: !state.showNewPass));
                      },
                      onChanged: (v) {
                        bloc.add(ChangeNewPassTextInput(newPass: v));
                      },
                    ),
                    SizedBox(
                      height: Dimens.d12.responsive(),
                    ),
                    formText(
                      S.current.confirm_new_pass,
                      state.showConfirmPass,
                       errrText: state.showConfPass == '' ? null : state.showConfPass,
                      onTap: () {
                        bloc.add(ShowConfiPassPress(showConf: !state.showConfirmPass));
                      },
                      onChanged: (v) {
                        bloc.add(ChangeConfirmPassTextInput(confirmPass: v));
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: Dimens.d12.responsive(),
                ),
                Row(
                  children: [
                    Expanded(child: Container()),
                    Expanded(
                      child: BlocBuilder<ChangePassBloc, ChangePassState>(
                        buildWhen: (previous, current) => previous.buttonState != current.buttonState,
                        builder: (context, state) {
                          return SizedBox(
                            height: Dimens.d40.responsive(),
                            child: AppElevatedButton(
                              state: state.buttonState,
                              onPressed: () {
                                bloc.add(const ChangePassPress());
                              },
                              buttonTitle: S.current.confirm,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Column formText(String title, bool show, {GestureTapCallback? onTap, Function(String)? onChanged, String? errrText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: title,
            style: typoInterNomal16.copyWith(color: colorTextMedium, fontWeight: FontWeight.w600, height: 1.5),
            children: <TextSpan>[
              TextSpan(
                text: '*',
                style: typoInterNomal14.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: colorSupportDanger,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: Dimens.d40.responsive(),
          child: AppTextFormField(
            borderRadius: 5,
            obscureText: show,
            onChanged: onChanged,
            hintText: title,
            errorText: errrText,
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
        ),
        errrText != ''
            ? const SizedBox(
                height: 4,
              )
            : Container(),
        errrText != ''
            ? Text(
                errrText ?? '',
                style: typoInterNomal14.copyWith(color: colorSupportDanger, fontSize: Dimens.d12.responsive()),
              )
            : Container(),
      ],
    );
  }
}
