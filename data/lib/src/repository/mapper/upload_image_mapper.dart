import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../../data.dart';
import '../model/upload_image_data.dart';

@Injectable()
class ImageUploadDataMapper extends BaseDataMapper<DataResponse<ImageUploadData>, ImageUpload> {
  @override
  ImageUpload mapToEntity(DataResponse<ImageUploadData>? data) {
    return ImageUpload(
      url: data?.data?.url ?? '',
      thumb: data?.data?.thumb ?? '',
      type: data?.data?.type ?? '',
      message: data?.message ?? '',
      statusCode: data?.status_code ?? 0,
    );
  }
}
