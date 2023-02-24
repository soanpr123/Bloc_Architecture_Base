import 'package:freezed_annotation/freezed_annotation.dart';

part 'amai_order_entry.freezed.dart';

@freezed
class AmaiOrder with _$AmaiOrder {
  const factory AmaiOrder({
    @Default(-1) int? id,
    @Default(-1) int? userId,
    @Default('') String? userName,
    @Default(0) int? type,
    @Default('') String? typeName,
    @Default(-1) int? lunchMenusId,
    @Default('') String? menuName,
    @Default(0) int? orderPrice,
    @Default('') String? orderDate,
  }) = _AmaiOrder;
}
