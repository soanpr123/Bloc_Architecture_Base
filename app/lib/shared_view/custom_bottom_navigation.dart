import 'package:flutter/material.dart';

import '../app.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({
    Key? key,
    // ignore: always_put_required_named_parameters_first
    required this.items,
     required this.total,
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
  final int total;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      notchMargin: 1,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (final item in items)
              Padding(
                padding:
                    EdgeInsets.only(left: items.indexOf(item) == 2 ? 32 : 0, right: items.indexOf(item) == 1 ? 32 : 0),
                child: Stack(
                  children: [
                    InkWell(
                      overlayColor: MaterialStateProperty.all(colorDisabled),
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Dimens.d100.responsive()),
                      ),
                      onTap: () => onTap?.call(items.indexOf(item)),
                      child: Container(
                        margin: margin,
                        width: 64,
                        height: 64,
                        child: Align(
                          alignment: Alignment.center,
                          child: Ink(
                            child: Image.asset(
                              item.icon,
                              width: item.iconSize ?? 24,
                              height: item.iconSize ?? 24,
                              color: items.indexOf(item) == currentIndex
                                  ? item.selectedColor ?? selectedItemColor ?? theme.primaryColor
                                  : item.unselectedColor ?? unselectedItemColor ?? theme.iconTheme.color,
                            ),
                          ),
                        ),
                      ),
                    ),
                    items.indexOf(item) == 2
                        ? Positioned(
                            top: Dimens.d12.responsive(),
                            right: Dimens.d14.responsive(),
                            child: GestureDetector(
                              child: Align(
                                alignment: Alignment.topRight,
                                child: total == 0
                                    ? Container()
                                    : Container(
                                        padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                                        width: 18,
                                        height: 18,
                                        decoration: BoxDecoration(
                                          color: colorSupportDanger,
                                          borderRadius: const BorderRadius.all(Radius.circular(30)),
                                        ),
                                        child: Center(
                                          child: Text(
                                            total >= 99 ? '99' : '$total',
                                            style: typoInterNomal14.copyWith(
                                              fontSize: 10,
                                              color: Colors.white,
                                              // height: 1,
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class CustomBottomBarItem {
    CustomBottomBarItem({
    required this.icon,
    required this.title,
    this.selectedColor,
    this.unselectedColor,
    this.iconSize,
    this.activeIcon,
  });
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

}
