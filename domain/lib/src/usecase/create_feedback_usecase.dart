import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain.dart';
import 'base/future/base_future_use_case_response.dart';

part 'create_feedback_usecase.freezed.dart';

@Injectable()
class CreateFeedBackUseCase extends BaseFutureResUseCase<CreateFeedBackInput, BaseEntryData> {
  CreateFeedBackUseCase(this._repository) : super();

  final Repository _repository;

  @protected
  @override
  Future<BaseEntryData> buildUseCase(CreateFeedBackInput input) {
    return _repository.createFeedback(request: input.request);
  }
}

@freezed
class CreateFeedBackInput extends BaseInput with _$CreateFeedBackInput {
  const factory CreateFeedBackInput({
    required Map<String, dynamic> request,
  }) = _CreateFeedBackInput;
}
