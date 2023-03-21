import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../../data.dart';

@Injectable()
class ListResourceDataMapper extends BaseDataMapper<ResourceData, ResourceDataEntry> {
  ListResourceDataMapper(
    this._categoryBlogsDataMapper,
  );

  final CategoryBlogsDataMapper _categoryBlogsDataMapper;
  @override
  ResourceDataEntry mapToEntity(ResourceData? data) {
    return ResourceDataEntry(
      category: _categoryBlogsDataMapper.mapToListEntity(data?.categoryPosts),
    );
  }
}
