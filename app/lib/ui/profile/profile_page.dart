import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

import '../../app.dart';
import '../../shared_view/app_netword_image.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends BasePageState<ProfilePage, ProfileBloc> {
  final nameCtrl = TextEditingController();
  @override
  void initState() {
    super.initState();
    commonBloc.add(const CommonPageInitiated());
  }

  @override
  void dispose() {
    super.dispose();
    nameCtrl.dispose();
  }

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
      body: BlocBuilder<AppBloc, AppState>(
        bloc: appBloc,
        buildWhen: (previous, current) => previous.users != current.users,
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              appBloc.add(const AppInitiated());
            },
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 32,
                ),
                BlocBuilder<ProfileBloc, ProfileState>(
                  buildWhen: (previous, current) => previous.changeAvt != current.changeAvt,
                  builder: (context, stateAvt) {
                    return stateAvt.changeAvt == AppElevatedButtonState.loading
                        ? SizedBox(
                            height: 100,
                            width: 100,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(50)),
                              child: Center(
                                child: Lottie.asset(Assets.json.loading,
                                    width: 100, height: 100, frameRate: FrameRate.max, repeat: true),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              navigator.showModalBottomSheet(AppPopupInfo.pickImageBottomSheet(
                                message: context,
                                onTap1: () async {
                                  bloc.add(const ChosseImageFromCamera());
                                  await navigator.pop();
                                },
                                onTap2: () async {
                                  bloc.add(const ChosseImageFromGallery());
                                  await navigator.pop();
                                },
                              ));
                            },
                            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                              Stack(children: [
                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                                    child: AppNetworkImageAvatar(
                                        source: state.users.incognito?.avatar ?? '', fit: BoxFit.cover),
                                  ),
                                ),
                                const Positioned(bottom: 0, right: 0, child: Icon(Icons.photo_camera)),
                              ]),
                            ]),
                          );
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.users.name ?? S.current.noname,
                      style: typoInterNomal18,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                BlocBuilder<ProfileBloc, ProfileState>(
                  buildWhen: (previous, current) =>
                      previous.showEditName != current.showEditName || previous.buttonState != current.buttonState,
                  builder: (context, stateProfile) {
                    nameCtrl.text = state.users.incognito?.name ?? '';

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (stateProfile.showEditName)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 200,
                                height: 35,
                                child: AppTextFormField(
                                  controller: nameCtrl,
                                  onChanged: (v) => bloc.add(EditNameTextField(name: v)),
                                  borderRadius: 10,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 40,
                                    child: AppElevatedButton(
                                      buttonTitle: S.current.cancel,
                                      mainColor: colorBrandSecondary,
                                      onPressed: () {
                                        bloc.add(const ShowEditNamePressed());
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  SizedBox(
                                    height: 40,
                                    child: AppElevatedButton(
                                      state: stateProfile.buttonState,
                                      buttonTitle: S.current.save,
                                      onPressed: () {
                                        bloc.add(const EditNamePressed());
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        else
                          Row(
                            children: [
                              Text(
                                '(${state.users.incognito?.name ?? S.current.no_orther_name})',
                                style: typoInterNomal14,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              // ignore: prefer-trailing-comma
                              GestureDetector(
                                onTap: () {
                                  bloc.add(const ShowEditNamePressed());
                                },
                                child: const Icon(
                                  Icons.edit,
                                  size: 20,
                                ),
                              )
                            ],
                          ),
                      ],
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      iconText(
                        title: NumberFormatUtils.formatNumbers(state.users.totalViewed ?? 0),
                        icon: Assets.svg.eyeLine.path,
                      ),
                      iconText(
                        icon: Assets.svg.heart.path,
                        title: NumberFormatUtils.formatNumbers(state.users.totalLikes ?? 0),
                      ),
                      iconText(
                        icon: Assets.svg.logoamai.path,
                        title: NumberFormatUtils.formatNumbers(state.users.totalAmais ?? 0),
                      ),
                    ],
                  ),
                ),
                buildButton(S.current.infomation_profile, onTap: () {
                  navigator.push(const AppRouteInfo.infomationProfile());
                }),
                buildButton(S.current.change_password, onTap: () {
                  navigator.push(const AppRouteInfo.changePassWord());
                }),
                buildButton(S.current.log_out, onTap: () {
                  navigator.showDialog(AppPopupInfo.dialogConfirmComon(
                    title: S.current.tell_me_logout,
                    onPress: () {
                      bloc.add(const LogOutRequest());
                    },
                  ));
                  // navigator.showDialog(AppPopupInfo.confirm(
                  //   message: S.current.tell_me_logout,
                  //   confirm: Func0(() async {

                  //   }),
                  // ));
                }),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildButton(String title, {GestureTapCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: boxShadow,
          color: Colors.white,
        ),
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: typoInterNomal14,
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget iconText({String? title, String? icon}) {
    return Row(
      children: [
        SvgPicture.asset(icon ?? ''),
        const SizedBox(
          width: 4,
        ),
        Text(
          title ?? '',
          style: typoInterNomal14,
        ),
      ],
    );
  }
}
