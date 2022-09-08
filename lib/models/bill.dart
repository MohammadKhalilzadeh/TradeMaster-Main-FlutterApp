import 'dart:convert';

Bill billFromJson(String str) => Bill.fromJson(json.decode(str));

String purchaseItemToJson(Bill data) => json.encode(data.toJson());

class Bill {
  final dynamic id;
  final dynamic shopName;
  final dynamic customerPhone;
  final dynamic customerAddress;
  final dynamic totalPrice;
  final dynamic partnerShare;
  final dynamic dateTime;
  final List<dynamic> items;
  final dynamic code;
  final dynamic authority;
  final dynamic refID;
  final dynamic extraDetail;
  final dynamic owner;
  final dynamic status;

  const Bill({
    required this.id,
    required this.shopName,
    required this.owner,
    required this.customerPhone,
    required this.customerAddress,
    required this.totalPrice,
    required this.partnerShare,
    required this.dateTime,
    required this.items,
    required this.code,
    required this.authority,
    required this.refID,
    required this.extraDetail,
    required this.status,
  });

  factory Bill.fromJson(Map<dynamic, dynamic> json) {
    return Bill(
      id: json['_id'],
      shopName: json['ShopName'],
      customerPhone: json['CustomerPhone'],
      customerAddress: json['CustomerAddress'],
      totalPrice: json['TotalPrice'],
      partnerShare: json['PartnerShare'],
      status: json['Status'],
      dateTime: json['Datetime'],
      items: json['items'],
      code: json['code'],
      authority: json['authority'],
      refID: json['refID'],
      extraDetail: json['extraDetail'],
      owner: json['owner'],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "ShopName": shopName,
        "owner": owner,
        "customerPhone": customerPhone,
        "CustomerAddress": customerAddress,
        "TotalPrice": totalPrice,
        "PartnerShare": partnerShare,
        "Datetime": dateTime,
        "items": items,
        "code": code,
        "authority": authority,
        "refID": refID,
        "extraDetail": extraDetail,
        "Status": status,
      };
}
