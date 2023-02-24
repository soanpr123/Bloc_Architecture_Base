import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app.dart';

/// AppTextStyle format as follows:
/// s[fontSize][fontWeight][Color]
/// Example: s18w400Primary

class AppTextStyles {
  AppTextStyles._();
  static const _defaultLetterSpacing = 0.03;

  static const _baseTextStyle = TextStyle(
    letterSpacing: _defaultLetterSpacing,
    // height: 1.0,
  );

  static TextStyle s14w400Primary({
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(TextStyle(
        fontSize: Dimens.d14.responsive(tablet: tablet, ultraTablet: ultraTablet),
        fontWeight: FontWeight.w400,
       
      ));

  static TextStyle s14w400Secondary({
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(TextStyle(
        fontSize: Dimens.d14.responsive(tablet: tablet, ultraTablet: ultraTablet),
        fontWeight: FontWeight.w400,
       
      ));
}



final typoInterNomal14 = GoogleFonts.inter(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
  fontSize: 14,
  letterSpacing: 1.02,
  color: colorTextDark,
);

final typoInterNomal16 = GoogleFonts.inter(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w600,
  fontSize: 16,
  letterSpacing: 1.02,
  color: colorTextDark,
);
final typoInterNomal18 = GoogleFonts.inter(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w700,
  fontSize: 18,
  letterSpacing: 1.02,
  color: colorTextDark,
);
