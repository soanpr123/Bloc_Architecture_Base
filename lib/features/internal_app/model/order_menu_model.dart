class OrderMenu {
  int? statusCode;
  String? message;
  String? errors;
  DataOrder? data;

  OrderMenu({this.statusCode, this.message, this.errors, this.data});

  OrderMenu.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    errors = json['errors'];
    data = json['data'] != null ?  DataOrder.fromJson(json['data']) : null;
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

class DataOrder {
  List<Canteen>? canteen;
  List<Other>? other;

  DataOrder({this.canteen, this.other});

  DataOrder.fromJson(Map<String, dynamic> json) {
    if (json['canteen'] != null) {
      canteen = <Canteen>[];
      json['canteen'].forEach((v) {
        canteen!.add( Canteen.fromJson(v));
      });
    }
    if (json['other'] != null) {
      other = <Other>[];
      json['other'].forEach((v) {
        other!.add( Other.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (canteen != null) {
      data['canteen'] = canteen!.map((v) => v.toJson()).toList();
    }
    if (other != null) {
      data['other'] = other!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Canteen {
  int? id;
  String? name;
  int? orderNo;

  Canteen({this.id, this.name, this.orderNo});

  Canteen.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    orderNo = json['order_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['order_no'] = orderNo;
    return data;
  }
}

class Other {
  int? id;
  String? name;
  int? orderNo;

  Other({this.id, this.name, this.orderNo});

  Other.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    orderNo = json['order_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['order_no'] = orderNo;
    return data;
  }
}
