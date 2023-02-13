import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/component/app_elevated_button.dart';
import 'package:project/component/app_text_form_field.dart';
import 'package:project/core/di/dependency_injection.dart';
import 'package:project/core/style/colors.dart';
import 'package:project/core/style/text_style.dart';
import 'package:project/core/style/transaction.dart';
import 'package:project/features/infomation_profile_page/cubit/infomation_profile_cubit.dart';
import 'package:project/features/profile_page/cubit/profile_cubit.dart';
import 'package:url_launcher/url_launcher_string.dart';

class InfomationProfilePage extends StatelessWidget {
  InfomationProfilePage({Key? key}) : super(key: key);
  final aboutCtrl = TextEditingController();
  final blocProfile = getIt<ProfileCubit>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: const BackButton(color: Colors.black),
          centerTitle: true,
          elevation: 1,
          title: Text(
            translation(context).infomation_profile,
            style: typoInterNomal18,
          ),
        ),
        body: BlocProvider(
          create: (context) => InfomationProfileCubit(),
          child: SafeArea(
            child: BlocBuilder<InfomationProfileCubit, InfomationProfileState>(
              builder: (context, state) {
                aboutCtrl.text = blocProfile.state.profile.incognito?.about ?? "";
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 32,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            translation(context).introduction_profile,
                            style: typoInterNomal18.copyWith(fontSize: 20),
                          ),
                          GestureDetector(
                            onTap: () {
                              context.read<InfomationProfileCubit>().showEdit(!state.showEdit);
                            },
                            child: Text(
                              translation(context).edit,
                              style:
                                  typoInterNomal14.copyWith(decoration: TextDecoration.underline, color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      if (!state.showEdit)
                        Text(
                          blocProfile.state.profile.incognito?.about ?? "Không có giới thiệu",
                          style: typoInterNomal14,
                        )
                      else
                        InfoWidget(
                          aboutCtrl: aboutCtrl,
                          state: state,
                        ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Text(
                            translation(context).infomation_profile,
                            style: typoInterNomal18.copyWith(fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      buildContent(translation(context).position_name, blocProfile.state.profile.positionName ?? ""),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                translation(context).work_status_name,
                                style: typoInterNomal16,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Text(
                                    blocProfile.state.profile.workStatusName ?? "",
                                    style: typoInterNomal14.copyWith(color: colorBrandPrimary),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  (blocProfile.state.profile.workStatus ?? 0) == 2
                                      ? Icon(
                                          Icons.check_circle_sharp,
                                          size: 20,
                                          color: colorBrandPrimary,
                                        )
                                      : Container()
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ],
                      ),
                      buildContent(translation(context).department, blocProfile.state.profile.department ?? ""),
                      buildContent(translation(context).join_company_at, blocProfile.state.profile.joinCompanyAt ?? ""),
                      buildContent(translation(context).up_official_at, blocProfile.state.profile.upOfficialAt ?? ""),
                      buildContent(translation(context).citizen_id, blocProfile.state.profile.citizenId ?? ""),
                      buildContent(translation(context).phone, blocProfile.state.profile.phone ?? ""),
                      buildContent(translation(context).email, blocProfile.state.profile.email ?? ""),
                      buildContent(translation(context).personal_email, blocProfile.state.profile.personalEmail ?? ""),
                      buildContent(translation(context).gender, blocProfile.state.profile.gender ?? ""),
                      buildContent(translation(context).dob, blocProfile.state.profile.dob ?? ""),
                      buildContent(translation(context).bank, blocProfile.state.profile.bank?.bank ?? ""),
                      buildContent(translation(context).address, blocProfile.state.profile.address ?? ""),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                translation(context).education,
                                style: typoInterNomal16,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 32,
                                child: Text(
                                  blocProfile.state.profile.education?.universityName ?? "",
                                  style: typoInterNomal14,
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 32,
                                child: Row(
                                  children: [
                                    Text(
                                      "${translation(context).graded_name}: ${blocProfile.state.profile.education?.gradedName ?? ""} - ${translation(context).gpa}: ${double.parse((blocProfile.state.profile.education?.gpa ?? "0")).toStringAsFixed(2)}",
                                      style: typoInterNomal14,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ],
                      ),
                      buildContent(translation(context).last_company, blocProfile.state.profile.lastCompany ?? ""),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                translation(context).socials,
                                style: typoInterNomal16,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 32,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${translation(context).face_book}: ",
                                          style: typoInterNomal14,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: GestureDetector(
                                            onTap: () {
                                              launchUrlString(blocProfile.state.profile.socials?.facebookUrl ?? "");
                                            },
                                            child: Text(
                                              blocProfile.state.profile.socials?.facebookUrl ?? "",
                                              style: typoInterNomal14.copyWith(color: colorBrandPrimary),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "${translation(context).telegram}: ",
                                          style: typoInterNomal14,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: GestureDetector(
                                            onTap: () {
                                              launchUrlString(blocProfile.state.profile.socials?.telegramUrl ?? "");
                                            },
                                            child: Text(
                                              blocProfile.state.profile.socials?.telegramUrl ?? "",
                                              style: typoInterNomal14.copyWith(color: colorBrandPrimary),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ));
  }

  Widget buildContent(String title, String content) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: typoInterNomal16,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              content,
              style: typoInterNomal14,
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ],
    );
  }
}

class InfoWidget extends StatelessWidget {
  const InfoWidget({super.key, required this.aboutCtrl, required this.state});
  final InfomationProfileState state;
  final TextEditingController aboutCtrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextFormField(
          borderRadius: 5,
          controller: aboutCtrl,
          maxLines: 10,
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
                buttonTitle: translation(context).cancel,
                mainColor: colorBrandSecondary,
                onPressed: () {
                  // bloc.editName(!state.showEditName);
                  context.read<InfomationProfileCubit>().showEdit(!state.showEdit);
                },
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            SizedBox(
              height: 40,
              child: AppElevatedButton(
                state: state.buttonState,
                buttonTitle: translation(context).save,
                onPressed: () {
                  // Future.delayed(Duration())?
                  context.read<InfomationProfileCubit>().updateMe(aboutCtrl.text.trim());
                },
              ),
            )
          ],
        )
      ],
    );
  }
}
