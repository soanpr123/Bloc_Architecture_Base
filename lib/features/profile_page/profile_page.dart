import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:project/component/app_elevated_button.dart';
import 'package:project/component/app_netword_image.dart';
import 'package:project/component/app_text_form_field.dart';
import 'package:project/core/di/dependency_injection.dart';
import 'package:project/core/routers/router.dart';
import 'package:project/core/style/colors.dart';
import 'package:project/core/style/resource.dart';
import 'package:project/core/style/text_style.dart';
import 'package:project/core/style/transaction.dart';
import 'package:project/core/utils/app_utils.dart';
import 'package:project/core/utils/enum/api_request_status.dart';
import 'package:project/features/profile_page/component/bottom_sheet_pick_image.dart';
import 'package:project/features/profile_page/component/dialog.dart';
import 'package:project/features/profile_page/component/icon_text.dart';
import 'package:project/features/profile_page/cubit/profile_cubit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final bloc = getIt<ProfileCubit>();
  final nameCtrl = TextEditingController();
  RefreshController refreshController = RefreshController(initialRefresh: false);
  @override
  void initState() {
    super.initState();
    bloc.getProfile();
  }

  @override
  void dispose() {
    super.dispose();
    nameCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<ProfileCubit, ProfileState>(
          bloc: bloc,
          listener: (_, listener) {},
          builder: (context, state) {
            nameCtrl.text = state.profile.incognito?.name ?? "";
            return SmartRefresher(
              controller: refreshController,
              onRefresh: () {
                bloc.getProfile();
                refreshController.refreshCompleted();
              },
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  if (state.apiRequestStatus == APIRequestStatus.loading)
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(50)),
                        child: Center(
                            child: Lottie.asset(R.ASSETS_JSON_LOADING_JSON,
                                width: 100, height: 100, frameRate: FrameRate.max, repeat: true)),
                      ),
                    ),
                  if (state.apiRequestStatus != APIRequestStatus.loading)
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext co) {
                              return BottomSheetPickImage();
                            });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                height: 100,
                                width: 100,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                                  child: AppNetworkImageAvatar(
                                    source: state.profile.avatar ?? "",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const Positioned(bottom: 0, right: 0, child: Icon(Icons.photo_camera)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.profile.name ?? translation(context).noname,
                        style: typoInterNomal18,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (state.showEditName)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                                width: 200,
                                height: 35,
                                child: AppTextFormField(
                                  controller: nameCtrl,
                                  borderRadius: 10,
                                )),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 40,
                                  child: AppElevatedButton(
                                    buttonTitle: translation(context).cancel,
                                    mainColor: colorBrandSecondary,
                                    onPressed: () {
                                      bloc.editName(!state.showEditName);
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
                                      bloc.updateMe(nameCtrl.text.trim());
                                    },
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      else
                        Row(
                          children: [
                            Text(
                              "(${state.profile.incognito?.name ?? translation(context).no_orther_name})",
                              style: typoInterNomal14,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            GestureDetector(
                              onTap: () {
                                bloc.editName(!state.showEditName);
                              },
                              child: const Icon(
                                Icons.edit,
                                size: 20,
                              ),
                            )
                          ],
                        ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconText(icon: R.ASSETS_SVG_EYE_LINE_SVG, text: formatNumber(state.profile.totalViewed ?? 0)),
                        IconText(icon: R.ASSETS_SVG_HEART_SVG, text: formatNumber(state.profile.totalLikes ?? 0)),
                        IconText(icon: R.ASSETS_SVG_LOGOAMAI_SVG, text: formatNumber(state.profile.totalAmais ?? 0))
                      ],
                    ),
                  ),
                  buildButton(translation(context).infomation_profile, onTap: () {
                    // context.router.push(InfomationProfileRoute());
                    AppRouter().push(InfomationProfileRoute());
                  }),
                  buildButton(translation(context).change_password, onTap: () {
                    context.router.push(ChangePasswordRoute());

                    // Routers().navigatorKey.currentContext?
                  }),
                  buildButton(translation(context).log_out, onTap: () {
                    showDialog(
                        context: (context),
                        barrierDismissible: false,
                        builder: (co) {
                          return DialogLogout(
                            state: state,
                            bloc: bloc,
                          );
                        });
                  })
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildButton(String title, {GestureTapCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: typoInterNomal14,
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.black38,
          )
        ],
      ),
    );
  }
}
