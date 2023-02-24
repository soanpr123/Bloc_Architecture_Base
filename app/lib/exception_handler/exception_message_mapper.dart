import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

class ExceptionMessageMapper {
  const ExceptionMessageMapper();

  String map(AppException appException) {
    switch (appException.appExceptionType) {
      case AppExceptionType.remote:
        final exception = appException as RemoteException;
        switch (exception.kind) {
          case RemoteExceptionKind.noInternet:
            return S.current.noInternetException;
          case RemoteExceptionKind.network:
            return S.current.noInternetException;
          case RemoteExceptionKind.serverDefined:
            return exception.generalServerMessage ?? S.current.unknownException;
          case RemoteExceptionKind.serverUndefined:
            return exception.generalServerMessage ?? S.current.unknownException;
          case RemoteExceptionKind.timeout:
            return S.current.noInternetException;
          case RemoteExceptionKind.cancellation:
            return S.current.cancellationException;
          case RemoteExceptionKind.unknown:
            return '${S.current.unknownException}: ${exception.rootException}';
          case RemoteExceptionKind.refreshTokenFailed:
            return S.current.tokenExpired;
        }
      case AppExceptionType.parse:
        return S.current.parseException;
      case AppExceptionType.remoteConfig:
        return S.current.unknownException;
      case AppExceptionType.uncaught:
        return S.current.unknownException;
      case AppExceptionType.validation:
        final exception = appException as ValidationException;
        switch (exception.kind) {
          case ValidationExceptionKind.emptyEmail:
            return S.current.email_blank;
          case ValidationExceptionKind.invalidEmail:
            return S.current.email_invalid;
          case ValidationExceptionKind.invalidPassword:
            return S.current.password_blank;
          case ValidationExceptionKind.invalidUserName:
            return S.current.email_invalid;
          case ValidationExceptionKind.invalidPhoneNumber:
            return S.current.email_invalid;
          case ValidationExceptionKind.invalidDateTime:
            return S.current.email_invalid;
          case ValidationExceptionKind.passwordsAreNotMatch:
            return S.current.same_pass_invalid;
        }
    }
  }
}
