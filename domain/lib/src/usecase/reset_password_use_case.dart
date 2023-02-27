import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../domain.dart';
import 'base/future/base_future_use_case_response.dart';

part 'reset_password_use_case.freezed.dart';

@Injectable()
class ResetPasswordUseCase extends BaseFutureResUseCase<ResetPasswordInput, BaseEntryData> {
  const ResetPasswordUseCase(this._repository);

  final Repository _repository;

  @protected
  @override
  Future<BaseEntryData> buildUseCase(ResetPasswordInput input) async {
    if (!ValidationUtils.isValidPassword(input.password) || !ValidationUtils.isPasswordValidExp(input.password)) {
      throw const ValidationException(ValidationExceptionKind.invalidPassword);
    }
    if (!ValidationUtils.isValidPassword(input.confirmPassword) ||
        !ValidationUtils.isPasswordValidExp(input.confirmPassword)) {
      throw const ValidationException(ValidationExceptionKind.invalidPassword);
    }

    if (!ValidationUtils.isValidPassword(input.newPass) || !ValidationUtils.isPasswordValidExp(input.newPass)) {
      throw const ValidationException(ValidationExceptionKind.invalidEmail);
    }
    if (input.newPass != input.confirmPassword) {
      throw const ValidationException(ValidationExceptionKind.passwordsAreNotMatch);
    }

    return await _repository.resetPassword(
      currentPass: input.password,
      newPass: input.newPass,
      confirmPassword: input.confirmPassword,
    );
  }
}

@freezed
class ResetPasswordInput extends BaseInput with _$ResetPasswordInput {
  const factory ResetPasswordInput({
    required String newPass,
    required String password,
    required String confirmPassword,
  }) = _ResetPasswordInput;
}

@freezed
class ResetPasswordOutput extends BaseOutput with _$ResetPasswordOutput {
  const ResetPasswordOutput._();

  const factory ResetPasswordOutput() = _ResetPasswordOutput;
}
