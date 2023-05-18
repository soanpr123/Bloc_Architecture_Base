import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

import '../../app.dart';
import 'bloc/home_bloc.dart';
import 'widget/dialog_donate.dart';
@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BasePageState<HomePage, HomeBloc> {
  final listMenu = [
    {
      'id': 0,
      'icon': Assets.png.icAmaiStore.path,
      'name': S.current.store,
      'onTap': const AppRouteInfo.amaiStore(),
    },
    {
      'id': 1,
      'icon': Assets.png.icNotification.path,
      'name': S.current.notifycation_local,
      'onTap': const AppRouteInfo.announmentPage(),
    },
    {
      'id': 2,
      'icon': Assets.png.icAmaiWiki.path,
      'name': S.current.wiki,
      'onTap': const AppRouteInfo.wikiPage(),
    },
    {
      'id': 3,
      'icon': Assets.png.icMember.path,
      'name': S.current.memberlist,
      'onTap': const AppRouteInfo.amaiMember(),
    },
    {
      'id': 4,
      'icon': Assets.png.icBlogs.path,
      'name': S.current.blogs,
      'onTap': const AppRouteInfo.listBlogsPage(''),
    },
    {
      'id': 5,
      'icon': Assets.png.icSendAmai.path,
      'name': S.current.send_amai,
      'onTap': const AppRouteInfo.sendAmai(-1),
    },
  ];
  @override
  void initState() {
    super.initState();
    appBloc.add(const AppGetPopUpDonate());
    // GetIt.instance.get<AnnounmentBloc>().add(const AnnounmentPageInitiated());
  }

  @override
  Widget buildPageListeners({required Widget child}) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AppBloc, AppState>(
          listenWhen: (previous, current) => previous.reloadHis != current.reloadHis,
          listener: (context, state) {
           
            appBloc.add(const AppInitiated(handleErr: false));
          },
        ),
        BlocListener<AppBloc, AppState>(
          listenWhen: (previous, current) =>
              previous.popUpDonateEntry != current.popUpDonateEntry || previous.reloadHis != current.reloadHis,
          listener: (context, state) {
            appBloc.add(const AppGetPopUpDonate());
            if (state.popUpDonateEntry.donor != '') {
   
              navigator.showDialog(AppPopupInfo.bottomSheet(
                  child: DialogDonate(
                popUpDonateEntry: state.popUpDonateEntry,
              ),),);
            }
          },
        ),
      ],
      child: child,
    );
  }

  @override
  Widget buildPage(BuildContext context) {
    Log.d(MediaQuery.of(context).devicePixelRatio, name: 'devicePixelRatio');

    return CommonScaffold(
      body: Stack(
        children: [
          Positioned(
            left: -Dimens.d14.responsive(),
            top: 0,
            bottom: Dimens.d512.responsive() / 2,
            child: Opacity(
              opacity: 0.1,
              child: Assets.png.imgBgGreen.image(width: Dimens.d558.responsive(), height: Dimens.d512.responsive()),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + Dimens.d33.responsive(),
              left: Dimens.d16.responsive(),
              right: Dimens.d16.responsive(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<AppBloc, AppState>(
                  bloc: appBloc,
                  buildWhen: (previous, current) =>
                      previous.users != current.users || previous.reloadHis != current.reloadHis,
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        state.users.name != ''
                            ? Text(
                                "Chào ${(state.users.name ?? "").split(' ').last}!",
                                style: typoInterNomal14.copyWith(
                                  color: colorTextDark,
                                  fontWeight: FontWeight.w700,
                                  fontSize: Dimens.d16.responsive(),
                                  height: 1.5,
                                ),
                              )
                            : Container(),
                        SizedBox(
                          height: Dimens.d4.responsive(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateTimeUtils.formatDate(),
                              style: typoInterNomal14.copyWith(
                                color: colorTextMedium,
                                fontWeight: FontWeight.w400,
                                fontSize: Dimens.d14.responsive(),
                                height: 1.5,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 13.5),
                              // decoration: BoxDecoration(
                              //   color: Colors.white,
                              //   borderRadius: const BorderRadius.all(Radius.circular(5)),
                              //   border: Border.all(color: colorUiBorder, width: 1),
                              // ),
                              child: Row(
                                children: [
                                  Assets.svg.logoHome
                                      .svg(width: Dimens.d20.responsive(), height: Dimens.d20.responsive()),
                                  SizedBox(
                                    width: Dimens.d4.responsive(),
                                  ),
                                  Text(
                                    '${state.users.totalAmais ?? 0}',
                                    style: typoInterNomal14.copyWith(
                                      color: colorTextMedium,
                                      fontWeight: FontWeight.w400,
                                      height: 1.5,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Dimens.d24.responsive(),
                                  ),
                                  Assets.svg.logoHome.svg(
                                    width: Dimens.d20.responsive(),
                                    height: Dimens.d20.responsive(),
                                    color: colorGray600,
                                  ),
                                  SizedBox(
                                    width: Dimens.d4.responsive(),
                                  ),
                                  Text(
                                    '${state.users.amaiVotes ?? 0}',
                                    style: typoInterNomal14.copyWith(
                                      color: colorTextMedium,
                                      fontWeight: FontWeight.w400,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: Dimens.d32.responsive(),
                ),
                Text(
                  S.current.function,
                  style: typoInterNomal16.copyWith(
                    color: colorTextDark,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                  ),
                ),
                SizedBox(
                  height: Dimens.d16.responsive(),
                ),

                AlignedGridView.count(
                  padding: EdgeInsets.zero,
                  itemCount: listMenu.length,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 24,
                  shrinkWrap: true,
                  clipBehavior: Clip.antiAlias,
                  itemBuilder: (ctx, i) {
                    final item = listMenu[i];

                    return GestureDetector(
                      onTap: () async {
                        // context.router.push(AmaiStoreRoute());
                        await navigator.push(item['onTap'] as AppRouteInfo);
                        appBloc.add(AppReloadHistory(reloadHis: appBloc.state.reloadHis));
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            width: Dimens.d56.responsive(),
                            height: Dimens.d56.responsive(),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: Dimens.d48.responsive(),
                                    height: Dimens.d48.responsive(),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(item['icon'].toString()),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                BlocBuilder<AppBloc, AppState>(
                                  bloc: appBloc,
                                  buildWhen: (previous, current) =>
                                      previous.users != current.users || previous.reloadHis != current.reloadHis,
                                  builder: (context, stateApp) {
                                    return item['id'] == 0
                                        ? stateApp.users.haveLunchMenu == true
                                            ? Align(
                                                alignment: Alignment.topRight,
                                                child: Container(
                                                  width: 12,
                                                  height: 12,
                                                  decoration: BoxDecoration(
                                                    color: colorSupportDanger,
                                                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                                                  ),
                                                ),
                                              )
                                            : Container()
                                        : item['id'] == 1
                                            ? stateApp.users.haveInternalAnnouncement == true
                                                ? Align(
                                                    alignment: Alignment.topRight,
                                                    child: Container(
                                                      width: 12,
                                                      height: 12,
                                                      decoration: BoxDecoration(
                                                        color: colorSupportDanger,
                                                        borderRadius: const BorderRadius.all(Radius.circular(30)),
                                                      ),
                                                    ),
                                                  )
                                                : Container()
                                            : Container();
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Dimens.d8.responsive(),
                          ),
                          Text(
                            item['name'].toString(),
                            textAlign: TextAlign.center,
                            style: typoInterNomal14.copyWith(
                              color: colorTextMedium,
                              fontWeight: FontWeight.w400,
                              fontSize: Dimens.d12.responsive(),
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                // Wrap(
                //   spacing: 24,
                //   children: listMenu
                //       .map(
                //         (e) => GestureDetector(
                //           onTap: () {
                //             // context.router.push(AmaiStoreRoute());
                //             navigator.push(const AppRouteInfo.amaiStore());
                //           },
                //           child: Column(
                //             children: [
                //               Container(
                //                 width: Dimens.d48.responsive(),
                //                 height: Dimens.d48.responsive(),
                //                 decoration: BoxDecoration(
                //                   image: DecorationImage(image: AssetImage(e['icon'].toString())),
                //                 ),
                //               ),
                //               SizedBox(
                //                 height: Dimens.d8.responsive(),
                //               ),
                //               Text(
                //                 e['name'].toString(),
                //                 style: typoInterNomal14.copyWith(
                //                   color: colorTextMedium,
                //                   fontWeight: FontWeight.w400,
                //                   fontSize: Dimens.d12.responsive(),
                //                   height: 1.5,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       )
                //       .toList(),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
