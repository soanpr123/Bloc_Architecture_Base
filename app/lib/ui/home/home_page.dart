import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

import '../../app.dart';
import 'bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BasePageState<HomePage, HomeBloc> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
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
                    child: Assets.png.imgBgGreen.image(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 16, left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<AppBloc, AppState>(
                    bloc: appBloc,
                    buildWhen: (previous, current) => previous.users != current.users,
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Chào \n${state.users.name ?? ""}!",
                                style: typoInterNomal14.copyWith(color: colorTextDark, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                DateTimeUtils.formatDate(),
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
                                Assets.svg.logoHome.svg(width: 24, height: 24),
                                const SizedBox(
                                  width: 8,
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: typoInterNomal14,
                                    text: S.current.amai_point(''),
                                    children: [
                                      TextSpan(
                                        text: '${state.users.totalAmais ?? 0}',
                                        style: typoInterNomal14.copyWith(
                                          color: colorBrandPrimary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(
                    height: 34,
                  ),
                  Text(
                    S.current.function,
                    style: typoInterNomal16.copyWith(color: colorTextDark, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      // context.router.push(AmaiStoreRoute());
                      navigator.push(const AppRouteInfo.amaiStore());
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage(Assets.png.icIconStore.path)),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          S.current.store,
                          style: typoInterNomal14.copyWith(
                            color: colorTextDark,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
