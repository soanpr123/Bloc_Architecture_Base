import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../../data.dart';

@Injectable()
class NotificationDataMapper extends BaseDataMapper<Data2Notification, AppNotification> {
  @override
  AppNotification mapToEntity(Data2Notification? data) {
    return AppNotification(
      id: data?.id ?? '-1',
      userName: data?.userName ?? '',
      avatar: data?.userAvatar ?? '',
      action: data?.action ?? '',
      others: data?.others,
      commentId: data?.commentId ?? 0,
      type: data?.type,
      slug: data?.slug,
      title: data?.title ?? '',
      createdAt: data?.createdAt,
      readAt: data?.readAt ?? '',
    );
  }
}
