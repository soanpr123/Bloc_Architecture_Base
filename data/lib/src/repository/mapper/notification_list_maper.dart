import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../../data.dart';

@Injectable()
class NotificationListDataMapper extends BaseDataMapper<NotificationData, ListNotification> {

  NotificationListDataMapper(this._notificationDataMapper,);

  final NotificationDataMapper _notificationDataMapper;
  @override
  ListNotification mapToEntity(NotificationData? data) {
    return ListNotification(
      notification: _notificationDataMapper.mapToListEntity(data?.data),
      perPage: data?.perPage??-1,
      currentPage: data?.currentPage??-1,
      total: data?.total??-1,
      totalPage:data?.totalPage??-1,
    );
  }
}
