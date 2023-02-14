class OrderedModel {
  int? statusCode;
  String? message;
  String? errors;
  DataOrdered? data;

  OrderedModel({this.statusCode, this.message, this.errors, this.data});

  OrderedModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    errors = json['errors'];
    data = json['data'] != null ? DataOrdered.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = statusCode;
    data['message'] = message;
    data['errors'] = errors;

    data['data'] = data;

    return data;
  }
}

class DataOrdered {
  int? id;
  int? userId;
  String? userName;
  int? type;
  String? typeName;
  int? lunchMenusId;
  String? menuName;
  int? orderPrice;
  String? orderDate;

  DataOrdered(
      {this.id,
      this.userId,
      this.userName,
      this.type,
      this.typeName,
      this.lunchMenusId,
      this.menuName,
      this.orderPrice,
      this.orderDate});

  DataOrdered.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userName = json['user_name'];
    type = json['type'];
    typeName = json['type_name'];
    lunchMenusId = json['lunch_menus_id'];
    menuName = json['menu_name'];
    orderPrice = json['order_price'];
    orderDate = json['order_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['type'] = type;
    data['type_name'] = typeName;
    data['lunch_menus_id'] = lunchMenusId;
    data['menu_name'] = menuName;
    data['order_price'] = orderPrice;
    data['order_date'] = orderDate;
    return data;
  }
}
