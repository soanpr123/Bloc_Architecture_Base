import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/core/routers/router.dart';
import 'package:project/core/style/app_style.dart';
import 'package:project/core/style/colors.dart';
import 'package:project/core/style/resource.dart';
import 'package:project/core/style/transaction.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [HomePageRouter(), AmaiPageRouter(), ProfilePageRouter()],
      bottomNavigationBuilder: (_, tabsRouter) {
        return Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: boxShadow),
          child: SalomonBottomBar(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: [
              SalomonBottomBarItem(
                selectedColor: colorBrandPrimary,
                icon: SvgPicture.asset(R.ASSETS_SVG_IC_HOME_SVG),
                title: Text(translation(context).home),
              ),
              SalomonBottomBarItem(
                selectedColor: colorBrandPrimary,
                icon: SvgPicture.asset(R.ASSETS_SVG_IC_STORE_SVG),
                title: Text(translation(context).store),
              ),
              SalomonBottomBarItem(
                selectedColor: colorBrandPrimary,
                icon: SvgPicture.asset(R.ASSETS_SVG_IC_PROFILE_SVG),
                title: Text(translation(context).me),
              ),
            ],
          ),
        );
      },
    );
  }
}
