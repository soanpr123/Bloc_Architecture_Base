import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../domain.dart';

part 'get_notification_unread_use_case.freezed.dart';

@Injectable()
class GetNotificationUnreadUseCase extends BaseLoadMoreUseCase<GetNotificationUnreadInput, AppNotification> {
  GetNotificationUnreadUseCase(this._repository) : super(initPage: PagingConstants.initialPage);

  final Repository _repository;

  @protected
  @override
  Future<PagedList<AppNotification>> buildUseCase(GetNotificationUnreadInput input) {
    return _repository.getNotificationUnread(
      page: page,
      limit: PagingConstants.itemsPerPage,
    );
  }
}

@freezed
class GetNotificationUnreadInput extends BaseInput with _$GetNotificationUnreadInput {
  const factory GetNotificationUnreadInput() = _GetNotificationUnreadInput;
}
