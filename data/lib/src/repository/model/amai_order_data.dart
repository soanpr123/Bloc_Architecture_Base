import 'package:freezed_annotation/freezed_annotation.dart';
part 'amai_order_data.freezed.dart';
part 'amai_order_data.g.dart';

@freezed
class AmaiOrderData with _$AmaiOrderData {
  const factory AmaiOrderData({
    int? id,
    @JsonKey(name: 'user_id') int? userId,
    @JsonKey(name: 'user_name') String? userName,
    int? type,
    @JsonKey(name: 'type_name') String? typeName,
    @JsonKey(name: 'lunch_menus_id') int? lunchMenusId,
    @JsonKey(name: 'menu_name') String? menuName,
    @JsonKey(name: 'order_price') int? orderPrice,
    @JsonKey(name: 'order_date') String? orderDate,
  }) = _AmaiOrderData;

  factory AmaiOrderData.fromJson(Map<String, dynamic> json) => _$AmaiOrderDataFromJson(json);
}
