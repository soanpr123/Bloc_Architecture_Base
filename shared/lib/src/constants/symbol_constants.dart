import 'package:flutter/painting.dart';

import '../../shared.dart';

class SymbolConstants {
  const SymbolConstants._();

  static const String yen = '￥';

  static const String amountStore = '35.000đ';
  static const String amaiNote = 'Thanh toán đồ canteen';
  static const int delayedApi = 1;
  static String get codePayment {
    switch (EnvConstants.flavor) {
      case Flavor.develop:
        return 'd027b407af65087107af498c6e2ae711';
      case Flavor.production:
        return '2ddd79164b88204e7431e1eaaea2d1fa';
    }
  }

  static int get amaipayment {
    switch (EnvConstants.flavor) {
      case Flavor.develop:
        return 3;
      case Flavor.production:
        return 2;
    }
    // ignore: member-ordering
  }

  // ignore: member-ordering
  static Map<String, TextStyle> atomOneLightTheme = {
    'root': const TextStyle(color: Color(0xff383a42), backgroundColor: Color(0xfff1f2f3)),
    'comment': const TextStyle(color: Color(0xffa0a1a7), fontStyle: FontStyle.italic),
    'quote': const TextStyle(color: Color(0xffa0a1a7), fontStyle: FontStyle.italic),
    'doctag': const TextStyle(color: Color(0xffa626a4)),
    'keyword': const TextStyle(color: Color(0xffa626a4)),
    'formula': const TextStyle(color: Color(0xffa626a4)),
    'section': const TextStyle(color: Color(0xffe45649)),
    'name': const TextStyle(color: Color(0xffe45649)),
    'selector-tag': const TextStyle(color: Color(0xffe45649)),
    'deletion': const TextStyle(color: Color(0xffe45649)),
    'subst': const TextStyle(color: Color(0xffe45649)),
    'literal': const TextStyle(color: Color(0xff0184bb)),
    'string': const TextStyle(color: Color(0xff50a14f)),
    'regexp': const TextStyle(color: Color(0xff50a14f)),
    'addition': const TextStyle(color: Color(0xff50a14f)),
    'attribute': const TextStyle(color: Color(0xff50a14f)),
    'meta-string': const TextStyle(color: Color(0xff50a14f)),
    'built_in': const TextStyle(color: Color(0xffc18401)),
    'attr': const TextStyle(color: Color(0xff986801)),
    'variable': const TextStyle(color: Color(0xff986801)),
    'template-variable': const TextStyle(color: Color(0xff986801)),
    'type': const TextStyle(color: Color(0xff986801)),
    'selector-class': const TextStyle(color: Color(0xff986801)),
    'selector-attr': const TextStyle(color: Color(0xff986801)),
    'selector-pseudo': const TextStyle(color: Color(0xff986801)),
    'number': const TextStyle(color: Color(0xff986801)),
    'symbol': const TextStyle(color: Color(0xff4078f2)),
    'bullet': const TextStyle(color: Color(0xff4078f2)),
    'link': const TextStyle(color: Color(0xff4078f2)),
    'meta': const TextStyle(color: Color(0xff4078f2)),
    'selector-id': const TextStyle(color: Color(0xff4078f2)),
    'title': const TextStyle(color: Color(0xff4078f2)),
    'emphasis': const TextStyle(fontStyle: FontStyle.italic),
    'strong': const TextStyle(fontWeight: FontWeight.bold),
  };
}
