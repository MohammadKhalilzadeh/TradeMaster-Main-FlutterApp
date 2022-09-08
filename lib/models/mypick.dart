import 'dart:convert';

MyPick purchaseItemFromJson(String str) => MyPick.fromJson(json.decode(str));

String purchaseItemToJson(MyPick data) => json.encode(data.toJson());

class MyPick {
  final String id;
  final String name;
  final String owner;
  final int price;
  final String unit;
  final String color;
  final String size;
  final int amount;
  final int total;

  const MyPick({
    required this.id,
    required this.name,
    required this.owner,
    required this.price,
    required this.unit,
    required this.color,
    required this.size,
    required this.amount,
    required this.total,
  });

  factory MyPick.fromJson(Map<String, dynamic> json) => MyPick(
        id: json['_id'],
        name: json['name'],
        owner: json['owner'],
        price: json['price'],
        unit: json['unit'],
        color: json['color'],
        size: json['size'],
        amount: json['amount'],
        total: json['total'],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "owner": owner,
        "price": price,
        "unit": unit,
        "color": color,
        "size": size,
        "amount": amount,
        "total": total,
      };
}
