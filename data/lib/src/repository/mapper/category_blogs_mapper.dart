import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../../data.dart';



@Injectable()
class CategoryBlogsDataMapper extends BaseDataMapper<CategoryPosts, CategoryPostEntry> {
  @override
  CategoryPostEntry mapToEntity(CategoryPosts? data) {
    return CategoryPostEntry(
      id: data?.id ?? -1,
      slug: data?.slug ?? '',
      name: data?.name ?? '',
    );
  }
}
