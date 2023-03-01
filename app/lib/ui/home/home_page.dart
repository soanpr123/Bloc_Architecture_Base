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
              top: MediaQuery.of(context).padding.top + Dimens.d32.responsive(),
              left: Dimens.d16.responsive(),
              right: Dimens.d16.responsive(),
            ),
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
                            state.users.name != ""
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
                            Text(
                              DateTimeUtils.formatDate(),
                              style: typoInterNomal14.copyWith(
                                color: colorTextMedium,
                                fontWeight: FontWeight.w400,
                                fontSize: Dimens.d14.responsive(),
                                height: 1.5,
                              ),
                            ),
                          ],
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
                              Assets.svg.logoHome.svg(width: Dimens.d20.responsive(), height: Dimens.d20.responsive()),
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
                                  width: Dimens.d20.responsive(), height: Dimens.d20.responsive(), color: colorGray600),
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
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                  ),
                ),
                SizedBox(
                  height: Dimens.d16.responsive(),
                ),
                GestureDetector(
                  onTap: () {
                    // context.router.push(AmaiStoreRoute());
                    navigator.push(const AppRouteInfo.amaiStore());
                  },
                  child: Column(
                    children: [
                      Container(
                        width: Dimens.d48.responsive(),
                        height: Dimens.d48.responsive(),
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage(Assets.png.icAmaiStore.path)),
                        ),
                      ),
                      SizedBox(
                        height: Dimens.d8.responsive(),
                      ),
                      Text(
                        S.current.store,
                        style: typoInterNomal14.copyWith(
                          color: colorTextMedium,
                          fontWeight: FontWeight.w400,
                          fontSize: Dimens.d12.responsive(),
                          height: 1.5,
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
    );
  }
}
