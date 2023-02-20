class AmaiHistory {
  int? statusCode;
  String? message;
  String? errors;
  DataModel? data;

  AmaiHistory({this.statusCode, this.message, this.errors, this.data});

  AmaiHistory.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    errors = json['errors'];
    data = json['data'] != null ?  DataModel.fromJson(json['data']) : null;
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

class DataModel {
  List<DataHistory>? data;
  int? perPage;
  int? totalPage;
  int? currentPage;
  int? total;

  DataModel({this.data, this.perPage, this.totalPage, this.currentPage, this.total});

  DataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataHistory>[];
      json['data'].forEach((v) {
        data!.add( DataHistory.fromJson(v));
      });
    }
    perPage = json['per_page'];
    totalPage = json['total_page'];
    currentPage = json['current_page'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    
      data['data'] = data;
    
    data['per_page'] = perPage;
    data['total_page'] = totalPage;
    data['current_page'] = currentPage;
    data['total'] = total;
    return data;
  }
}

class DataHistory {
  int? id;
  int? amountAmais;
  String? note;
  String? createdAt;

  DataHistory({this.id, this.amountAmais, this.note, this.createdAt});

  DataHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amountAmais = json['amount_amais'];
    note = json['note'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['amount_amais'] = amountAmais;
    data['note'] = note;
    data['created_at'] = createdAt;
    return data;
  }
}
