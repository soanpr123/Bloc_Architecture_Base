import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../model/profile_data.dart';
import 'base/base_data_mapper.dart';

@Injectable()
class EducateDataMapper extends BaseDataMapper<EducationData, Educate> {
  @override
  Educate mapToEntity(EducationData? data) {
    return Educate(
      gradedName: data?.gradedName,
      graded: data?.graded,
      gpa: data?.gpa,
      gpaFormat: data?.gpaFormat,
      universityCode: data?.universityCode,
      universityName: data?.universityName,
    );
  }
}
