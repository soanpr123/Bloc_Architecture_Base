import 'package:flutter/material.dart';

import 'package:shared/shared.dart';

enum AppRoute {
  splash,
  login,
}

enum Gender {
  male(ServerRequestResponseConstants.male),
  female(ServerRequestResponseConstants.female),
  other(ServerRequestResponseConstants.other),
  unknown(ServerRequestResponseConstants.unknown);

  const Gender(this.serverValue);
  final int serverValue;
}

enum LanguageCode {
  en(localeCode: LocaleConstants.en, serverValue: ServerRequestResponseConstants.en),
  vn(localeCode: LocaleConstants.vn, serverValue: ServerRequestResponseConstants.vn);

  const LanguageCode({
    required this.localeCode,
    required this.serverValue,
  });
  final String localeCode;
  final String serverValue;

  static LanguageCode get defaultValue => en;
}

enum NotificationType {
  unknown,
  newPost,
  liked,
}

enum BottomTab {
  home(icon: Icon(Icons.home), activeIcon: Icon(Icons.home)),
  search(icon: Icon(Icons.search), activeIcon: Icon(Icons.search)),
  myPage(icon: Icon(Icons.people), activeIcon: Icon(Icons.people));

  const BottomTab({
    required this.icon,
    required this.activeIcon,
  });
  final Icon icon;
  final Icon activeIcon;
}
