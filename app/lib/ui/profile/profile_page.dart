import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

import '../../app.dart';
import '../../shared_view/app_netword_image.dart';
@RoutePage()
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
  Widget buildPageListeners({required Widget child}) {
    // TODO: implement buildPageListeners
    return MultiBlocListener(
      listeners: [
        BlocListener<AppBloc, AppState>(
          listenWhen: (previous, current) => previous.reload != current.reload,
          listener: (context, state) {
            if (bloc.state.showEditName) {
              bloc.add(const ShowEditNamePressed());
            }
            // appBloc.add(const AppReloadNotipage(reload: false));
          },
        ),
      ],
      child: child,
    );
  }

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
      body: BlocBuilder<AppBloc, AppState>(
        bloc: appBloc,
        buildWhen: (previous, current) => previous.users != current.users || previous.reload != current.reload,
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
                                child: Lottie.asset(Assets.json.loadmore.path,
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
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    padding: EdgeInsets.all(Dimens.d4.responsive()),
                                    decoration: BoxDecoration(
                                      color: colorBrandSecondary,
                                      borderRadius: const BorderRadius.all(Radius.circular(3)),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Assets.svg.cameraLine
                                            .svg(width: Dimens.d20.responsive(), height: Dimens.d20.responsive()),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                            ]),
                          );
                  },
                ),
                SizedBox(
                  height: Dimens.d12.responsive(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    iconText(
                      title: NumberFormatUtils.formatNumbers(state.users.totalViewed ?? 0),
                      icon: Assets.svg.eyeLine.path,
                    ),
                    SizedBox(
                      width: Dimens.d8.responsive(),
                    ),
                    iconText(
                      icon: Assets.svg.heart.path,
                      title: NumberFormatUtils.formatNumbers(state.users.totalLikes ?? 0),
                    ),
                    SizedBox(
                      width: Dimens.d8.responsive(),
                    ),
                    iconText(
                      icon: Assets.svg.logoamai.path,
                      title: NumberFormatUtils.formatNumbers(state.users.totalAmais ?? 0),
                    ),
                  ],
                ),
                SizedBox(
                  height: Dimens.d8.responsive(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.users.name ?? S.current.noname,
                      style: typoInterNomal18.copyWith(height: 1.5),
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

                    return stateProfile.showEditName
                        ? Padding(
                            padding: EdgeInsets.fromLTRB(
                              Dimens.d16.responsive(),
                              Dimens.d12.responsive(),
                              Dimens.d16.responsive(),
                              Dimens.d12.responsive(),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  height: Dimens.d32.responsive(),
                                  child: AppTextFormField(
                                    controller: nameCtrl,
                                    hintText: '(Biệt danh)',
                                    onChanged: (v) => bloc.add(EditNameTextField(name: v)),
                                    borderRadius: 3,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                    0,
                                    Dimens.d12.responsive(),
                                    0,
                                    Dimens.d12.responsive(),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: Dimens.d32.responsive(),
                                          child: AppElevatedButton(
                                            buttonTitle: S.current.cancel,
                                            borderRadius: const BorderRadius.all(Radius.circular(3)),
                                            mainColor: colorBrandSecondary,
                                            onPressed: () {
                                              bloc.add(const ShowEditNamePressed());
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: Dimens.d32.responsive(),
                                          child: AppElevatedButton(
                                            borderRadius: const BorderRadius.all(Radius.circular(3)),
                                            state: stateProfile.buttonState,
                                            buttonTitle: S.current.save,
                                            onPressed: () {
                                              bloc.add(const EditNamePressed());
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '(${state.users.incognito?.name ?? S.current.no_orther_name})',
                                style: typoInterNomal14.copyWith(height: 1.5, color: colorTextMedium),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              // ignore: prefer-trailing-comma
                              GestureDetector(
                                onTap: () {
                                  bloc.add(const ShowEditNamePressed());
                                },
                                child: Assets.svg.edit2Line
                                    .svg(width: Dimens.d20.responsive(), height: Dimens.d20.responsive()),
                              )
                            ],
                          );
                  },
                ),
                SizedBox(
                  height: Dimens.d12.responsive(),
                ),
                buildButton(
                  S.current.infomation_profile,
                  Assets.svg.accountCircleLine.svg(width: Dimens.d20.responsive(), height: Dimens.d20.responsive()),
                  onTap: () async {
                    await navigator.push(const AppRouteInfo.infomationProfile());
                  },
                ),
                buildButton(
                  'QR của tôi',
                  Assets.svg.qrCodeLine.svg(width: Dimens.d20.responsive(), height: Dimens.d20.responsive()),
                  onTap: () async {
                    await navigator.push(AppRouteInfo.myQrCodePage(state.users.qrCode ?? '', state.users.name ?? ''));
                  },
                ),
                buildButton(
                  S.current.change_password,
                  Assets.svg.lock.svg(width: Dimens.d20.responsive(), height: Dimens.d20.responsive()),
                  onTap: () async {
                    await navigator.push(const AppRouteInfo.changePassWord());
                  },
                ),
                buildButton(
                  S.current.report,
                  Assets.svg.bugLine.svg(width: Dimens.d20.responsive(), height: Dimens.d20.responsive()),
                  onTap: () async {
                    await navigator.push(const AppRouteInfo.reportPage());
                  },
                ),
                buildButton(
                  S.current.log_out,
                  Assets.svg.logout.svg(width: Dimens.d20.responsive(), height: Dimens.d20.responsive()),
                  onTap: () {
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
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildButton(
    String title,
    Widget icon, {
    Function()? onTap,
  }) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(colorDisabled),
      ),
      onPressed: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            icon,
            SizedBox(
              width: Dimens.d8.responsive(),
            ),
            Text(
              title,
              style: typoInterNomal14,
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
          style: typoInterNomal14.copyWith(height: 1.5),
        ),
      ],
    );
  }
}
