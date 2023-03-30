import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../../data.dart';

@Injectable()
class ListResourceDataMapper extends BaseDataMapper<ResourceData, ResourceDataEntry> {
  ListResourceDataMapper(
    this._categoryBlogsDataMapper,
    this._donationRecipientDataMapper,
  );

  final CategoryBlogsDataMapper _categoryBlogsDataMapper;
  final DonationRecipientDataMapper _donationRecipientDataMapper;
  @override
  ResourceDataEntry mapToEntity(ResourceData? data) {
    return ResourceDataEntry(
      category: _categoryBlogsDataMapper.mapToListEntity(data?.categoryPosts),
      memberSend: _donationRecipientDataMapper.mapToListEntity(data?.donationRecipient),
    );
  }
}
