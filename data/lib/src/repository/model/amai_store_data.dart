import 'package:freezed_annotation/freezed_annotation.dart';
part 'amai_store_data.freezed.dart';
part 'amai_store_data.g.dart';

@freezed
class Canteen with _$Canteen {
  const factory Canteen({
    int? id,
    String? name,
    @JsonKey(name: 'order_no') int? orderNo,
  }) = _Canteen;

  factory Canteen.fromJson(Map<String, dynamic> json) => _$CanteenFromJson(json);
}

@freezed
class Other with _$Other {
  const factory Other({
    int? id,
    String? name,
    @JsonKey(name: 'order_no') dynamic orderNo,
  }) = _Other;

  factory Other.fromJson(Map<String, dynamic> json) => _$OtherFromJson(json);
}

@freezed
class AmaiStoreData with _$AmaiStoreData {
  const factory AmaiStoreData({
    List<Canteen>? canteen,
    List<Other>? other,
  }) = _AmaiStoreData;

  factory AmaiStoreData.fromJson(Map<String, dynamic> json) => _$AmaiStoreDataFromJson(json);
}
