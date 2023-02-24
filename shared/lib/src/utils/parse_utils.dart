import '../../shared.dart';

class ParseUtils {
  const ParseUtils._();

  static BigDecimal parseStringToBigDecimal(String value) {
    try {
      return BigDecimal.parse(value);
    } on FormatException catch (e) {
      throw ParseException(ParseExceptionKind.invalidSourceFormat, e);
    }
  }

  static int parseStringToInt(String value) {
    try {
      return int.parse(value);
    } on FormatException catch (e) {
      throw ParseException(ParseExceptionKind.invalidSourceFormat, e);
    }
  }

  static double parseStringToDouble(String value) {
    try {
      return double.parse(value);
    } on FormatException catch (e) {
      throw ParseException(ParseExceptionKind.invalidSourceFormat, e);
    }
  }

  static String splitGroub(String value) {
    try {
      if (value != '') {
        final parts = value.split(' ');
        final dateString = parts[1];
        final dateParts = dateString.split("-");
        final resultString = '${dateParts[1]}/${dateParts[2]}';

        return resultString;
      } else {
        return '';
      }
    } on FormatException catch (e) {
      throw ParseException(ParseExceptionKind.invalidSourceFormat, e);
    }
  }
}
