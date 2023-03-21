import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain.dart';

part 'resource_data.freezed.dart';

@freezed
class ResourceDataEntry with _$ResourceDataEntry {
  const factory ResourceDataEntry({
    @Default(<CategoryPostEntry>[]) List<CategoryPostEntry>? category,
  }) = _ResourceDataEntry;
}
