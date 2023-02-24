import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain.dart';
import 'base/future/base_future_use_case_response.dart';

part 'get_total_unread_notifi.freezed.dart';

@Injectable()
class GetTotalNotificationUseCase extends BaseFutureResUseCase<GetTotalNotificationInput, BaseEntryData> {
  GetTotalNotificationUseCase(this._repository) : super();

  final Repository _repository;

  @protected
  @override
  Future<BaseEntryData> buildUseCase(GetTotalNotificationInput input) {
    return _repository.getTotalNotificationUnread();
  }
}

@freezed
class GetTotalNotificationInput extends BaseInput with _$GetTotalNotificationInput {
  const factory GetTotalNotificationInput() = _GetTotalNotificationInput;
}
