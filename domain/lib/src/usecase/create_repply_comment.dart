import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain.dart';
import 'base/future/base_future_use_case_response.dart';

part 'create_repply_comment.freezed.dart';

@Injectable()
class CreateRepplyCommentUseCase extends BaseFutureResUseCase<CreateReppllyCommentInput, BaseEntryData> {
  CreateRepplyCommentUseCase(this._repository) : super();

  final Repository _repository;

  @protected
  @override
  Future<BaseEntryData> buildUseCase(CreateReppllyCommentInput input) {
    return _repository.createRepplyComent(input.id, input.slugs, input.comment);
  }
}

@freezed
class CreateReppllyCommentInput extends BaseInput with _$CreateReppllyCommentInput {
  const factory CreateReppllyCommentInput({
    required String id,
    required String slugs,
    required String comment,
  }) = _CreateReppllyCommentInput;
}
