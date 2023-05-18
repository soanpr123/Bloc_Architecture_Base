import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain.dart';
import 'base/future/base_future_use_case_response.dart';

part 'create_comment_usecase.freezed.dart';

@Injectable()
class CreateCommentUseCase extends BaseFutureResUseCase<CreateCommentInput, BaseEntryData> {
  CreateCommentUseCase(this._repository) : super();

  final Repository _repository;

  @protected
  @override
  Future<BaseEntryData> buildUseCase(CreateCommentInput input) {
    return _repository.createComent(input.slugs, input.comment);
  }
}

@freezed
class CreateCommentInput extends BaseInput with _$CreateCommentInput {
  const factory CreateCommentInput({
    required String slugs,
    required String comment,
  }) = _CreateCommentInput;
}
