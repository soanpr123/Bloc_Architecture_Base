import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../../data.dart';
import '../model/blogs_model_data.dart';

@Injectable()
class TagsDataMapper extends BaseDataMapper<Tags, TagsEntry> {
  @override
  TagsEntry mapToEntity(Tags? data) {
    return TagsEntry(
      id: data?.id ?? -1,
      name: data?.name ?? '',
    );
  }
}

@Injectable()
class AuthorDataMapper extends BaseDataMapper<Author, AuthorEntry> {
  @override
  AuthorEntry mapToEntity(Author? data) {
    return AuthorEntry(
      avatar: data?.avatar ?? '',
      name: data?.name ?? '',
    );
  }
}
