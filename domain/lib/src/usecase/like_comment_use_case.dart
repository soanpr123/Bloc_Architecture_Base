import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain.dart';
import 'base/future/base_future_use_case_response.dart';

part 'like_comment_use_case.freezed.dart';

@Injectable()
class LikeComentUseCase extends BaseFutureResUseCase<LikeComentInput, BaseEntryData> {
  LikeComentUseCase(this._repository) : super();

  final Repository _repository;

  @protected
  @override
  Future<BaseEntryData> buildUseCase(LikeComentInput input) {
    return _repository.likeComent(slungs: input.slungs, id: input.id);
  }
}

@freezed
class LikeComentInput extends BaseInput with _$LikeComentInput {
  const factory LikeComentInput({
    required String slungs,
    required int id,
  }) = _LikeComentInput;
}
