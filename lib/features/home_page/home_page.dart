import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/component/app_netword_image.dart';
import 'package:project/component/build_body.dart';
import 'package:project/core/di/dependency_injection.dart';
import 'package:project/core/routers/router.dart';
import 'package:project/core/style/app_style.dart';
import 'package:project/core/style/colors.dart';
import 'package:project/core/style/resource.dart';
import 'package:project/core/style/text_style.dart';
import 'package:project/core/style/transaction.dart';
import 'package:project/core/utils/app_utils.dart';
import 'package:project/features/home_page/cubit/home_page_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bloc = getIt<HomePageCubit>();

  @override
  void initState() {
    super.initState();
    bloc.requestTotalUnread();
    bloc.getProfile();
    bloc.requestNotifycationLocal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        actions: [
          BlocBuilder<HomePageCubit, HomePageState>(
            bloc: bloc,
            builder: (context, state) {
              return Stack(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      // width: 60,
                      height: 32,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          color: colorBrandPrimary, borderRadius: const BorderRadius.all(Radius.circular(30))),
                      child: Row(children: [
                        SvgPicture.asset(
                          R.ASSETS_SVG_IC_LOGO_WHITE_SVG,
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          formatNumber(state.profile.totalAmais ?? 0),
                          style: typoInterNomal14.copyWith(color: Colors.white),
                        )
                      ]),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(
            width: 8,
          ),
          BlocBuilder<HomePageCubit, HomePageState>(
            bloc: bloc,
            builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  context.router.push(NotificationRoute());
                },
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                            color: colorBrandPrimary, borderRadius: const BorderRadius.all(Radius.circular(30))),
                        child: Center(
                          child: SvgPicture.asset(
                            R.ASSETS_SVG_IC_NOTIFICATION_SVG,
                            width: 20,
                            height: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        margin: const EdgeInsets.only(left: 16),
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                            color: colorSupportDanger, borderRadius: const BorderRadius.all(Radius.circular(30))),
                        child: Center(
                            child: Text(
                          state.totalUnread >= 99 ? "+99" : "${state.totalUnread}",
                          style: typoInterNomal14.copyWith(fontSize: 10, color: Colors.white),
                        )),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(
            width: 16,
          ),
        ],
        elevation: 1,
        title: Row(
          children: [
            SvgPicture.asset(
              R.ASSETS_SVG_LOGO_HOME_SVG,
              width: 32,
              height: 32,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              translation(context).app_name,
              style: typoInterNomal18,
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            height: 180,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(R.ASSETS_PNG_BG_TECH_PNG),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
              ),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    translation(context).tite_banner,
                    style: typoInterNomal18.copyWith(color: Colors.white, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    translation(context).content_banner,
                    style: typoInterNomal14.copyWith(color: Colors.white, fontSize: 16),
                  ),
                ]),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  translation(context).notifycation_local,
                  style: typoInterNomal18.copyWith(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                GestureDetector(
                  onTap: () {
                    context.router.push(const AnnouncementRoute());
                  },
                  child: Text(
                    translation(context).more,
                    style: typoInterNomal14.copyWith(color: Colors.blue, decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          BlocBuilder<HomePageCubit, HomePageState>(
            bloc: bloc,
            builder: (context, state) {
              // print(state.enablePull);
              return BodyBuilder(
                  apiRequestStatus: state.notifyCationLocalStatus,
                  child: Container(
                    height: 85,
                    // color: Colors.amber,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      // physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: state.announcementData.map((e) {
                        return GestureDetector(
                          onTap: () {
                            context.router.push(AnnouncementDetailRoute(slug: e.slug, useCase: "home"));
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            // height: 50,
                            width: 250,
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                            decoration: BoxDecoration(
                                boxShadow: boxShadow,
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(Radius.circular(5))),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.title ?? "",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: typoInterNomal16.copyWith(fontSize: 16),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(e.createdAt ?? ""),
                                    ],
                                  )
                                ]),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  reload: () {});
            },
          )
        ]),
      ),
    );
  }
}
