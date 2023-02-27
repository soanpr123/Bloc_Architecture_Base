import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain.dart';
import 'base/future/base_future_use_case_response.dart';

part 'get_announcementdetail_use_case.freezed.dart';

@Injectable()
class AnnouncementDetailUseCase extends BaseFutureResUseCase<AnnouncementDetailInput, AnnouncementDetail> {
  AnnouncementDetailUseCase(this._repository) : super();

  final Repository _repository;

  @protected
  @override
  Future<AnnouncementDetail> buildUseCase(AnnouncementDetailInput input) {
    return _repository.getAnnouncementsDetail(slungs: input.slungs);
  }
}

@freezed
class AnnouncementDetailInput extends BaseInput with _$AnnouncementDetailInput {
  const factory AnnouncementDetailInput({
    required String slungs,
  }) = _AnnouncementDetailInput;
}
