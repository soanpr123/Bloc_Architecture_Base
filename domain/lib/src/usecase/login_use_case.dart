import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../domain.dart';
import 'base/future/base_future_use_case_response.dart';

part 'login_use_case.freezed.dart';

@Injectable()
class LoginUseCase extends BaseFutureResUseCase<LoginInput, Token> {
  const LoginUseCase(this._repository);

  final Repository _repository;

  @protected
  @override
  Future<Token> buildUseCase(LoginInput input) async {
    if (!ValidationUtils.isValidEmail(input.email)) {
      throw const ValidationException(ValidationExceptionKind.invalidEmail);
    }

    if (!ValidationUtils.isValidPassword(input.password)) {
      throw const ValidationException(ValidationExceptionKind.invalidPassword);
    }

    final token = await _repository.login(input.email, input.password);

    return token;
  }
}

@freezed
class LoginInput extends BaseInput with _$LoginInput {
  const factory LoginInput({
    required String email,
    required String password,
  }) = _LoginInput;
}
