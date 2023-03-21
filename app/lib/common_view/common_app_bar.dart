import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  CommonAppBar({
    Key? key,
    this.text,
    this.onLeadingPressed,
    this.onTitlePressed,
    this.leadingIcon,
    this.titleType = AppBarTitle.text,
    this.centerTitle,
    this.elevation,
    this.actions,
    this.height,
    this.automaticallyImplyLeading = true,
    this.flexibleSpace,
    this.bottom,
    this.shadowColor,
    this.shape,
    this.backgroundColor,
    this.foregroundColor,
    this.iconTheme,
    this.actionsIconTheme,
    this.primary = true,
    this.excludeHeaderSemantics = false,
    this.titleSpacing,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
    this.leadingWidth,
    this.titleTextStyle,
    this.systemOverlayStyle,
    this.leadingIconColor,
    this.corlorText,
  })  : preferredSize = Size.fromHeight(
          height ?? Dimens.d50.responsive(),
        ),
        super(key: key);

  final String? text;
  final Color? corlorText;
  final VoidCallback? onLeadingPressed;
  final VoidCallback? onTitlePressed;
  final Widget? leadingIcon;
  final AppBarTitle titleType;
  final bool? centerTitle;
  final double? elevation;
  final List<Widget>? actions;
  final double? height;
  final bool automaticallyImplyLeading;
  final Widget? flexibleSpace;
  final PreferredSizeWidget? bottom;
  final Color? shadowColor;
  final ShapeBorder? shape;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final IconThemeData? iconTheme;
  final IconThemeData? actionsIconTheme;
  final bool primary;
  final bool excludeHeaderSemantics;
  final double? titleSpacing;
  final double toolbarOpacity;
  final double bottomOpacity;
  final double? leadingWidth;
  final TextStyle? titleTextStyle;
  final Color? leadingIconColor;
  final SystemUiOverlayStyle? systemOverlayStyle;

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: preferredSize.height,
      automaticallyImplyLeading: automaticallyImplyLeading,
      flexibleSpace: flexibleSpace,
      bottom: bottom,
      shadowColor: shadowColor,
      shape: shape,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      iconTheme: iconTheme,
      actionsIconTheme: actionsIconTheme,
      primary: primary,
      excludeHeaderSemantics: excludeHeaderSemantics,
      titleSpacing: titleSpacing,
      toolbarOpacity: toolbarOpacity,
      bottomOpacity: bottomOpacity,
      leadingWidth: leadingWidth,
      systemOverlayStyle: systemOverlayStyle,
      leading: Padding(
        padding: EdgeInsets.only(top: Dimens.d12.responsive(), bottom: Dimens.d12.responsive()),
        child: leadingIcon,
      ),
      centerTitle: centerTitle,
      title: GestureDetector(
        onTap: onTitlePressed,
        behavior: HitTestBehavior.translucent,
        child: titleType == AppBarTitle.text
            ? Padding(
                padding: EdgeInsets.only(top: Dimens.d16.responsive(), bottom: Dimens.d12.responsive()),
                child: Text(
                  text ?? '',
                  style: typoInterNomal18.copyWith(
                    color: corlorText ?? colorTextDark,
                    fontSize: Dimens.d20.responsive(),
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                  ),
                ),
              )
            : titleType == AppBarTitle.logo
                ? _buildIcon(Assets.svg.logoHome)
                : null,
      ),
      actions: actions,
      elevation: elevation,
    );
  }

  Widget _buildIcon(SvgGenImage svg) {
    return svg.svg(
      color: leadingIconColor,
      width: Dimens.d24.responsive(),
      height: Dimens.d24.responsive(),
    );
  }
}

enum LeadingIcon {
  back,
  close,
  hambuger,
  none,
}

enum AppBarTitle {
  logo,
  text,
  none,
}
