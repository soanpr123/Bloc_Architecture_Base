import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:project/component/custom_bottom_navigation.dart';
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
      routes: const [HomePageRouter(), HistoryRouter(), NotifiCationRouter(), ProfilePageRouter()],
      floatingActionButton: FloatingActionButton(
        shape: const StadiumBorder(side: BorderSide(color: Colors.white, width: 2)),
        backgroundColor: colorBrandPrimary,
        child: Container(
          child: Lottie.asset(
            width: 32,
            height: 32,
            R.ASSETS_JSON_QRCODE_JSON,
            frameRate: FrameRate.max,
            repeat: true,
          ),
        ),
        onPressed: () {
          context.router.push(const QrCodeRoute());
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBuilder: (_, tabsRouter) {
        return CustomBottomNavigation(
          selectedItemColor: colorBrandPrimary,
          unselectedItemColor: colorGray400,
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: [
            CustomBottomBarItem(
              selectedColor: colorBrandPrimary,
              icon: R.ASSETS_PNG_IC_HOME_BTB_PNG,
              title: Text(translation(context).home),
            ),
            CustomBottomBarItem(
              selectedColor: colorBrandPrimary,
              icon: R.ASSETS_PNG_IC_SHOPPING_BTBAR_PNG,
              title: Text(translation(context).store),
            ),
            CustomBottomBarItem(
              selectedColor: colorBrandPrimary,
              icon: R.ASSETS_PNG_IC_NOTIFICATION_BTB_PNG,
              title: Text(translation(context).me),
            ),
            CustomBottomBarItem(
              selectedColor: colorBrandPrimary,
              icon: R.ASSETS_PNG_IC_USER_BTB_PNG,
              title: Text(translation(context).me),
            ),
          ],
        );
      },
    );
  }
}
