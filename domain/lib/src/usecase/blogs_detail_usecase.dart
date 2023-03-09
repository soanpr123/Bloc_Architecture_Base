import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain.dart';
import 'base/future/base_future_use_case_response.dart';

part 'blogs_detail_usecase.freezed.dart';

@Injectable()
class BlogsDetailUseCase extends BaseFutureResUseCase<BlogsDetailInput, BlogsDetailEntry> {
  BlogsDetailUseCase(this._repository) : super();

  final Repository _repository;

  @protected
  @override
  Future<BlogsDetailEntry> buildUseCase(BlogsDetailInput input) {
    return _repository.getDetailBlogs(slungs: input.slungs);
  }
}

@freezed
class BlogsDetailInput extends BaseInput with _$BlogsDetailInput {
  const factory BlogsDetailInput({
    required String slungs,
  }) = _BlogsDetailInput;
}
