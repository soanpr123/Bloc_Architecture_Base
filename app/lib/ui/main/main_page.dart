import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:resources/resources.dart';

import '../../app.dart';

import '../../shared_view/custom_bottom_navigation.dart';
import 'bloc/main_bloc.dart';
import 'bloc/main_event.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends BasePageState<MainPage, MainBloc> {
  @override
  void initState() {
    super.initState();
    // commonBloc.add(const CommonPageInitiated());
    bloc.add(const MainPageInitiated());
  }

  @override
  Widget buildPage(BuildContext context) {
    return AutoTabsScaffold(
      extendBody: true,
      routes: (navigator as AppNavigatorImpl).tabRoutes,
      floatingActionButton: FloatingActionButton(
        shape: const StadiumBorder(side: BorderSide(color: Colors.white, width: 2)),
        backgroundColor: colorBrandPrimary,
        child: Container(
          child: Assets.svg.icScan.svg(width: Dimens.d32.responsive(), height: Dimens.d32.responsive()),
        ),
        onPressed: () async {
          // context.router.push(const QrCodeRoute());?
          await navigator.push(const AppRouteInfo.qrCode());
          appBloc.add(const AppInitiated());
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBuilder: (_, tabsRouter) {
        (navigator as AppNavigatorImpl).tabsRouter = tabsRouter;

        return BlocBuilder<AppBloc, AppState>(
          bloc: appBloc,
          // buildWhen: (previous, current) => previous.total != current.total,
          builder: (context, state) {
            return CustomBottomNavigation(
              total: state.total,
              selectedItemColor: colorBrandPrimary,
              unselectedItemColor: colorGray400,
              margin: const EdgeInsets.symmetric(
                horizontal: 0,
                vertical: 16,
              ),
              currentIndex: tabsRouter.activeIndex,
              onTap: (i) {
                if (i == tabsRouter.activeIndex) {
                  navigator.popUntilRoot();
                } else {
                  tabsRouter.setActiveIndex(i);
                }
              },
              items: [
                CustomBottomBarItem(
                  selectedColor: colorBrandPrimary,
                  icon: Assets.png.icHomeBtb.path,
                  title: Text(S.current.home),
                ),
                CustomBottomBarItem(
                  selectedColor: colorBrandPrimary,
                  icon: Assets.png.icHistory.path,
                  title: Text(S.current.store),
                ),
                CustomBottomBarItem(
                  selectedColor: colorBrandPrimary,
                  icon: Assets.png.icNotificationBtb.path,
                  title: Text(S.current.notification),
                ),
                CustomBottomBarItem(
                  selectedColor: colorBrandPrimary,
                  icon: Assets.png.icUserBtb.path,
                  title: Text(S.current.me),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
