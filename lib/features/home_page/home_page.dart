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
import 'package:weather/weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bloc = getIt<HomePageCubit>();
  late WeatherFactory wf;
  @override
  void initState() {
    super.initState();
    wf = WeatherFactory("117afa26ec4c7faf9fd17412f24af46b");
    bloc.queryWeather(wf);
    bloc.requestTotalUnread();
    bloc.getProfile();
    bloc.requestNotifycationLocal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned(
              left: -16,
              top: 50,
              bottom: 0,
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Opacity(
                    opacity: 0.2,
                    child: Image.asset(
                      R.ASSETS_PNG_IMG_BG_GREEN_PNG,
                      // fit: Boxfi,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 16, left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<HomePageCubit, HomePageState>(
                    bloc: bloc,
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Chào \n${state.profile.name ?? ""}!",
                                style: typoInterNomal14.copyWith(color: colorTextDark, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                "hôm nay ${state.temp}℃",
                                style: typoInterNomal14.copyWith(
                                    color: colorTextMedium, fontWeight: FontWeight.w400, fontSize: 12),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 13.67, vertical: 13.5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(color: colorUiBorder, width: 1),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(R.ASSETS_SVG_LOGOAMAI_SVG),
                                const SizedBox(
                                  width: 8,
                                ),
                                RichText(
                                    text: TextSpan(
                                        style: typoInterNomal14,
                                        text: translation(context).amai_point(""),
                                        children: [
                                      TextSpan(
                                          text: "${state.profile.totalAmais ?? 0}",
                                          style: typoInterNomal14.copyWith(
                                              color: colorBrandPrimary, fontWeight: FontWeight.w600))
                                    ]))
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  ),
                  const SizedBox(
                    height: 34,
                  ),
                  Text(translation(context).function,
                      style: typoInterNomal16.copyWith(color: colorTextDark, fontWeight: FontWeight.w700)),
                  const SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.router.push(AmaiStoreRoute());
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: const BoxDecoration(
                              image: DecorationImage(image: AssetImage(R.ASSETS_PNG_IC_ICON_STORE_PNG))),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(translation(context).store,
                            style: typoInterNomal14.copyWith(
                                color: colorTextDark, fontWeight: FontWeight.w400, fontSize: 12)),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
