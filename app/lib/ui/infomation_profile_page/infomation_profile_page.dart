import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

import '../../app.dart';
import 'bloc/infomation_profile_page_bloc.dart';
import 'bloc/infomation_profile_page_event.dart';
import 'bloc/infomation_profile_page_state.dart';

class InfomationProfilePage extends StatefulWidget {
  const InfomationProfilePage({Key? key}) : super(key: key);

  @override
  _InfomationProfilePageState createState() => _InfomationProfilePageState();
}

class _InfomationProfilePageState extends BasePageState<InfomationProfilePage, InfomationProfileBloc> {
  final aboutCtrl = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    aboutCtrl.dispose();
  }

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
      appBar: CommonAppBar(
        leadingIcon: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        text: S.current.infomation_profile,
      ),
      body: BlocBuilder<AppBloc, AppState>(
        buildWhen: (previous, current) => previous.users != current.users,
        builder: (context, state) {
          aboutCtrl.text = state.users.incognito?.about ?? '';

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.current.introduction_profile,
                      style: typoInterNomal18.copyWith(fontSize: 20),
                    ),
                    GestureDetector(
                      onTap: () {
                        // context.read<InfomationProfileCubit>().showEdit(!state.showEdit);
                        bloc.add(InfomationProfileShowEditInput(show: bloc.state.showEdit));
                      },
                      child: Text(
                        S.current.edit,
                        style: typoInterNomal14.copyWith(decoration: TextDecoration.underline, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                BlocBuilder<InfomationProfileBloc, InfomationProfilePageState>(
                  buildWhen: (previous, current) => previous.showEdit != current.showEdit,
                  builder: (context, stateInfo) {
                    return !stateInfo.showEdit
                        ? Text(
                            state.users.incognito?.about ?? 'Không có giới thiệu',
                            style: typoInterNomal14,
                          )
                        : InfoWidget(
                            aboutCtrl: aboutCtrl,
                            bloc: bloc,
                          );
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Text(
                      S.current.infomation_profile,
                      style: typoInterNomal18.copyWith(fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                buildContent(
                  S.current.position_name,
                  state.users.positionName ?? '',
                  context,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.current.work_status_name,
                          style: typoInterNomal16,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Text(
                              state.users.workStatusName ?? '',
                              style: typoInterNomal14.copyWith(color: colorBrandPrimary),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            (state.users.workStatus ?? 0) == 2
                                ? Icon(
                                    Icons.check_circle_sharp,
                                    size: 20,
                                    color: colorBrandPrimary,
                                  )
                                : Container(),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ],
                ),
                buildContent(
                  S.current.department,
                  state.users.department ?? '',
                  context,
                ),
                buildContent(
                  S.current.join_company_at,
                  state.users.joinCompanyAt ?? '',
                  context,
                ),
                buildContent(
                  S.current.up_official_at,
                  state.users.upOfficialAt ?? '',
                  context,
                ),
                buildContent(S.current.citizen_id, state.users.citizenId ?? '', context),
                buildContent(S.current.phone, state.users.phone ?? '', context),
                buildContent(S.current.email, state.users.email ?? '', context),
                buildContent(
                  S.current.personal_email,
                  state.users.personalEmail ?? '',
                  context,
                ),
                buildContent(S.current.gender, state.users.gender ?? '', context),
                buildContent(S.current.dob, state.users.dob ?? '', context),
                buildContent(S.current.bank, state.users.bank?.bank ?? '', context),
                buildContent(S.current.address, state.users.address ?? '', context),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.current.education,
                      style: typoInterNomal16,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      state.users.education?.universityName ?? '',
                      style: typoInterNomal14,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          "${S.current.graded_name}: ${state.users.education?.gradedName ?? ""} - ${S.current.gpa}: ${double.parse(state.users.education?.gpa ?? "0").toStringAsFixed(2)}",
                          style: typoInterNomal14,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
                buildContent(
                  S.current.last_company,
                  state.users.lastCompany ?? '',
                  context,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.current.socials,
                            style: typoInterNomal16,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          GestureDetector(
                            onTap: () {
                              IntentUtils.openBrowserURL(
                                url: state.users.socials?.facebookUrl ?? '',
                                inApp: false,
                              );
                            },
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    state.users.socials?.facebookUrl ?? '',
                                    style: typoInterNomal14.copyWith(color: colorBrandPrimary),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            '${S.current.telegram}: ',
                            style: typoInterNomal14,
                          ),
                          GestureDetector(
                            onTap: () {
                              IntentUtils.openBrowserURL(
                                url: state.users.socials?.telegramUrl ?? '',
                                inApp: false,
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                  state.users.socials?.telegramUrl ?? '',
                                  style: typoInterNomal14.copyWith(color: colorBrandPrimary),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildContent(String title, String content, BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: typoInterNomal16,
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      content,
                      style: typoInterNomal14,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ignore: prefer-single-widget-per-file
class InfoWidget extends StatelessWidget {
  const InfoWidget({super.key, required this.aboutCtrl, required this.bloc});

  final TextEditingController aboutCtrl;
  final InfomationProfileBloc bloc;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextFormField(
          borderRadius: 5,
          controller: aboutCtrl,
          maxLines: 10,
          onChanged: (v) => bloc.add(InfomationProfilePageTextfieldInput(text: v)),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 40,
              child: AppElevatedButton(
                buttonTitle: S.current.cancel,
                mainColor: colorBrandSecondary,
                onPressed: () {
                  bloc.add(InfomationProfileShowEditInput(show: bloc.state.showEdit));
                },
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            BlocBuilder<InfomationProfileBloc, InfomationProfilePageState>(
              bloc: bloc,
              buildWhen: (previous, current) => previous.buttonState != current.buttonState,
              builder: (context, state) {
                return SizedBox(
                  height: 40,
                  child: AppElevatedButton(
                    state: state.buttonState,
                    buttonTitle: S.current.save,
                    onPressed: () {
                      // Future.delayed(Duration())?
                      // context.read<InfomationProfileCubit>().updateMe(aboutCtrl.text.trim());
                      bloc.add(const InfomationProfilePageInitiated());
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
