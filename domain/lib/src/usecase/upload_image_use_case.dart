import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain.dart';
import 'base/future/base_future_use_case_response.dart';

part 'upload_image_use_case.freezed.dart';

@Injectable()
class UploadImageUseCase extends BaseFutureResUseCase<UploadImageInput, ImageUpload> {
  const UploadImageUseCase(this._repository);

  final Repository _repository;

  @protected
  @override
  Future<ImageUpload> buildUseCase(UploadImageInput input) async {
    final output = await _repository.upLoadImage(input.file, input.type);

    return output;
  }
}

@freezed
class UploadImageInput extends BaseInput with _$UploadImageInput {
  const factory UploadImageInput({
    required File file,
    required String type,
  }) = _UploadImageInput;
}
