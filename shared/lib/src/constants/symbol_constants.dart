import '../../shared.dart';

class SymbolConstants {
  const SymbolConstants._();

  static const String yen = '￥';

  static const String amountStore = '35.000đ';
  static const String amaiNote = 'Thanh toán đồ canteen';
  static const int delayedApi = 2;
  static String get codePayment {
    switch (EnvConstants.flavor) {
      case Flavor.develop:
        return 'd027b407af65087107af498c6e2ae711';
      case Flavor.qa:
        return 'd027b407af65087107af498c6e2ae711';
      case Flavor.staging:
        return 'd027b407af65087107af498c6e2ae711';
      case Flavor.production:
        return '2ddd79164b88204e7431e1eaaea2d1fa';
    }
  }

  static int get amaipayment {
    switch (EnvConstants.flavor) {
      case Flavor.develop:
        return 3;
      case Flavor.qa:
        return 5;
      case Flavor.staging:
        return 5;
      case Flavor.production:
        return 2;
    }
  }
}
