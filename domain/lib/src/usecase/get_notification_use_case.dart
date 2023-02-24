import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../domain.dart';

part 'get_notification_use_case.freezed.dart';

@Injectable()
class GetNotificationUseCase extends BaseLoadMoreUseCase<GetNotificationInput, AppNotification> {
  GetNotificationUseCase(this._repository) : super(initPage: PagingConstants.initialPage);

  final Repository _repository;

  @protected
  @override
  Future<PagedList<AppNotification>> buildUseCase(GetNotificationInput input) {
    return _repository.getNotification(
      page: page,
      limit: PagingConstants.itemsPerPage,
    );
  }
}

@freezed
class GetNotificationInput extends BaseInput with _$GetNotificationInput {
  const factory GetNotificationInput({required int page}) = _GetNotificationInput;
}
