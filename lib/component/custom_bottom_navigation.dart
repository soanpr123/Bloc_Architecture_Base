import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/core/di/dependency_injection.dart';
import 'package:project/core/style/colors.dart';
import 'package:project/core/style/text_style.dart';
import 'package:project/features/home_page/cubit/home_page_cubit.dart';

class CustomBottomNavigation extends StatelessWidget {
  /// A list of tabs to display, ie `Home`, `Likes`, etc
  final List<CustomBottomBarItem> items;

  /// The tab to display.
  final int currentIndex;

  /// Returns the index of the tab that was tapped.
  final Function(int)? onTap;

  /// The color of the icon and text when the item is selected.
  final Color? selectedItemColor;

  /// The color of the icon and text when the item is not selected.
  final Color? unselectedItemColor;

  /// The opacity of color of the touchable background when the item is selected.
  final double? selectedColorOpacity;

  /// The border shape of each item.
  final ShapeBorder itemShape;

  /// A convenience field for the margin surrounding the entire widget.
  final EdgeInsets margin;

  /// The padding of each item.
  final EdgeInsets itemPadding;

  /// The transition duration
  final Duration duration;

  /// The transition curve
  final Curve curve;
  CustomBottomNavigation({
    Key? key,
    required this.items,
    this.currentIndex = 0,
    this.onTap,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.selectedColorOpacity,
    this.itemShape = const StadiumBorder(),
    this.margin = const EdgeInsets.all(8),
    this.itemPadding = const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeOutQuint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 4,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (final item in items)
              Container(
                width: 64,
                height: 64,
                child: GestureDetector(
                  onTap: () => onTap?.call(items.indexOf(item)),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          item.icon,
                          width: item.iconSize ?? 24,
                          height: item.iconSize ?? 24,
                          color: items.indexOf(item) == currentIndex
                              ? item.selectedColor ?? selectedItemColor ?? theme.primaryColor
                              : item.unselectedColor ?? unselectedItemColor ?? theme.iconTheme.color,
                        ),
                      ),
                      items.indexOf(item) == 2
                          ? BlocBuilder<HomePageCubit, HomePageState>(
                              bloc: getIt<HomePageCubit>(),
                              builder: (context, state) {
                                return GestureDetector(
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: state.totalUnread == 0
                                        ? Container()
                                        : Container(
                                            margin: const EdgeInsets.only(top: 8, right: 8),
                                            width: 24,
                                            height: 24,
                                            decoration: BoxDecoration(
                                                color: colorSupportDanger,
                                                borderRadius: const BorderRadius.all(Radius.circular(30))),
                                            child: Center(
                                                child: Text(
                                              state.totalUnread >= 99 ? "+99" : "${state.totalUnread}",
                                              style: typoInterNomal14.copyWith(fontSize: 10, color: Colors.white),
                                            )),
                                          ),
                                  ),
                                );
                              },
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

class CustomBottomBarItem {
  /// An icon to display.
  final String icon;

  /// An icon to display when this tab bar is active.
  final Widget? activeIcon;

  /// Text to display, ie `Home`
  final Widget title;

  /// A primary color to use for this tab.
  final Color? selectedColor;

  /// The color to display when this tab is not selected.
  final Color? unselectedColor;
  final double? iconSize;
  CustomBottomBarItem({
    required this.icon,
    required this.title,
    this.selectedColor,
    this.unselectedColor,
    this.iconSize,
    this.activeIcon,
  });
}