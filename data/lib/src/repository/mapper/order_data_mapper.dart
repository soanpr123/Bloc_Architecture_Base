import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../model/amai_order_data.dart';

import 'base/base_data_mapper.dart';

@Injectable()
class AmaiOrderDataMapper extends BaseDataMapper<AmaiOrderData, AmaiOrder> {
  @override
  AmaiOrder mapToEntity(AmaiOrderData? data) {
    return AmaiOrder(
      id: data?.id,
      userId: data?.userId,
      userName: data?.userName,
      type: data?.type,
      typeName: data?.typeName,
      lunchMenusId: data?.lunchMenusId,
      menuName: data?.menuName,
      orderPrice: data?.orderPrice,
      orderDate: data?.orderDate,
    );
  }
}
