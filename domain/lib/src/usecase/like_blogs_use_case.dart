import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain.dart';
import 'base/future/base_future_use_case_response.dart';

part 'like_blogs_use_case.freezed.dart';

@Injectable()
class LikeBlogsUseCase extends BaseFutureResUseCase<LikeBlogsInput, BaseEntryData> {
  LikeBlogsUseCase(this._repository) : super();

  final Repository _repository;

  @protected
  @override
  Future<BaseEntryData> buildUseCase(LikeBlogsInput input) {
    return _repository.likeBlogs(slungs: input.slungs);
  }
}

@freezed
class LikeBlogsInput extends BaseInput with _$LikeBlogsInput {
  const factory LikeBlogsInput({
    required String slungs,
  
  }) = _LikeBlogsInput;
}
