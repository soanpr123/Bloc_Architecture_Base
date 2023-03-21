import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../../data.dart';

@Injectable()
class ListBlogsDataMapper extends BaseDataMapper<ListBlogsData, ListBlogsDataEntry> {
  ListBlogsDataMapper(
    this._blogsDataMapper,
  );

  final BlogsDataMapper _blogsDataMapper;
  @override
  ListBlogsDataEntry mapToEntity(ListBlogsData? data) {
    return ListBlogsDataEntry(
      blogs: _blogsDataMapper.mapToListEntity(data?.data),
      perPage: data?.perPage ?? -1,
      currentPage: data?.currentPage ?? -1,
      total: data?.total ?? -1,
      totalPage: data?.totalPage ?? -1,
    );
  }
}
