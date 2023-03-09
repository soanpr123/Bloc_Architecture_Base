import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain.dart';
import 'base/future/base_future_use_case_response.dart';

part 'detail_wiki.freezed.dart';

@Injectable()
class WikiDetailUseCase extends BaseFutureResUseCase<WikiDetailInput, WikiDetail> {
  WikiDetailUseCase(this._repository) : super();

  final Repository _repository;

  @protected
  @override
  Future<WikiDetail> buildUseCase(WikiDetailInput input) {
    return _repository.getDetailWiki(slungs: input.slungs);
  }
}

@freezed
class WikiDetailInput extends BaseInput with _$WikiDetailInput {
  const factory WikiDetailInput({
    required String slungs,
  }) = _WikiDetailInput;
}
