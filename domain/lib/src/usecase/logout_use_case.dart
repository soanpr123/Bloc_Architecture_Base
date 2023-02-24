import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain.dart';
import 'base/future/base_future_use_case_response.dart';

part 'logout_use_case.freezed.dart';

@Injectable()
class LogoutUseCase extends BaseFutureResUseCase<LogoutInput, BaseEntryData> {
  const LogoutUseCase(this._repository);

  final Repository _repository;

  @protected
  @override
  Future<BaseEntryData> buildUseCase(LogoutInput input) async {
    return _repository.isLoggedIn ? await _repository.logout() : const BaseEntryData(data: '');
  }
}

@freezed
class LogoutInput extends BaseInput with _$LogoutInput {
  const factory LogoutInput() = _LogoutUseCase;
}

@freezed
class LogoutOutput extends BaseOutput with _$LogoutOutput {
  const LogoutOutput._();

  const factory LogoutOutput() = _LogoutOutput;
}
