import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:trader/models/bill.dart';
import 'package:trader/models/business.dart';
import 'package:trader/models/category.dart';
import 'package:trader/models/item.dart';
import 'package:trader/models/mypick.dart';
import 'package:trader/models/user.dart';

Future<User> getUser(String url, String address, {var headers}) async {
  final response = await http
      .get(
        Uri.parse(url + address),
        headers: headers,
      )
      .timeout(
        const Duration(seconds: 20),
      );

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to Load");
  }
}

Future<Business> getBusiness(String url, String address, {var headers}) async {
  final response = await http
      .get(
        Uri.parse(url + address),
        headers: headers,
      )
      .timeout(
        const Duration(seconds: 20),
      );

  if (response.statusCode == 200) {
    return Business.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to Load");
  }
}

Future<Item> getItem(String url, String address, {var headers}) async {
  final response = await http
      .get(
        Uri.parse(url + address),
        headers: headers,
      )
      .timeout(
        const Duration(seconds: 20),
      );

  if (response.statusCode == 200) {
    return Item.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to Load");
  }
}

Future<Bill> getaBill(String url, String address, {var headers}) async {
  final response = await http
      .get(
        Uri.parse(url + address),
        headers: headers,
      )
      .timeout(
        const Duration(seconds: 20),
      );

  if (response.statusCode == 200) {
    return Bill.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to Load");
  }
}

Future<List<Business>> getrequestBusiness(String url, String address,
    {var headers}) async {
  List<dynamic> values = <dynamic>[];
  List<Business> _businesses = <Business>[];
  final response = await http
      .get(
        Uri.parse(url + address),
        headers: headers,
      )
      .timeout(
        const Duration(seconds: 20),
      );

  if (response.statusCode == 200) {
    values = jsonDecode(response.body);
    if (values.isNotEmpty) {
      for (var i = 0; i < values.length; i++) {
        _businesses = values.map((e) => Business.fromJson(e)).toList();
      }
    }
  }

  return _businesses;
}

Future<List<Item>> getrequestItems(String url, String address,
    {var headers}) async {
  List<dynamic> values = <dynamic>[];
  List<Item> _items = <Item>[];
  final response = await http
      .get(
        Uri.parse(url + address),
        headers: headers,
      )
      .timeout(
        const Duration(seconds: 20),
      );

  if (response.statusCode == 200) {
    values = jsonDecode(response.body);
    if (values.isNotEmpty) {
      for (var i = 0; i < values.length; i++) {
        _items = values.map((e) => Item.fromJson(e)).toList();
      }
    }
  }

  return _items;
}

Future<List<User>> getUsers(String url, String address, {var headers}) async {
  List<dynamic> values = <dynamic>[];
  List<User> _businesses = <User>[];
  final response = await http
      .get(
        Uri.parse(url + address),
        headers: headers,
      )
      .timeout(
        const Duration(seconds: 20),
      );

  if (response.statusCode == 200) {
    values = jsonDecode(response.body);
    if (values.isNotEmpty) {
      for (var i = 0; i < values.length; i++) {
        _businesses = values.map((e) => User.fromJson(e)).toList();
      }
    }
  }
  return _businesses;
}

Future<List<Category>> getCategories(String url, String address,
    {var headers}) async {
  List<dynamic> values = <dynamic>[];
  List<Category> _businesses = <Category>[];
  final response = await http
      .get(
        Uri.parse(url + address),
        headers: headers,
      )
      .timeout(
        const Duration(seconds: 20),
      );

  if (response.statusCode == 200) {
    values = jsonDecode(response.body);
    if (values.isNotEmpty) {
      for (var i = 0; i < values.length; i++) {
        _businesses = values.map((e) => Category.fromJson(e)).toList();
      }
    }
  }
  return _businesses;
}

Future<List<Bill>> getBills(
  String url,
  String address, {
  var headers,
}) async {
  List<dynamic> values = <dynamic>[];
  List<Bill> _bills = <Bill>[];
  final response = await http
      .get(
        Uri.parse(url + address),
        headers: headers,
      )
      .timeout(
        const Duration(seconds: 20),
      );

  values = jsonDecode(response.body);
  if (response.statusCode == 200) {
    for (var i = 0; i < values.length; i++) {
      Bill bill = Bill.fromJson(values[i]);
      // _bills = values.map((e) => Bill.fromJson(e)).toList();
      _bills.add(bill);
    }
  }
  return _bills;
}

Future<List<MyPick>> billPicks(
  String url,
  String address, {
  var headers,
}) async {
  List<dynamic> values = <dynamic>[];
  List<MyPick> picks = <MyPick>[];
  final response = await http
      .get(
        Uri.parse(url + address),
        headers: headers,
      )
      .timeout(
        const Duration(seconds: 20),
      );

  Map<dynamic, dynamic> list = jsonDecode(response.body);
  var bill = Bill.fromJson(list);
  values = bill.items;

  if (response.statusCode == 200) {
    for (var i = 0; i < values.length; i++) {
      MyPick pick = MyPick.fromJson(values[i]);
      picks.add(pick);
    }
  } else {}

  return picks;
}

Future<http.Response> postrequest(
  String url,
  String address,
  var body, {
  var headers,
}) async {
  return await http
      .post(
        Uri.parse(url + address),
        body: body,
        headers: headers,
      )
      .timeout(
        const Duration(seconds: 20),
      );
}

Future<http.Response> patchRequest(
  String url,
  String address,
  var body,
  BuildContext context, {
  var headers,
}) async {
  final response = await http
      .patch(
    Uri.parse(url + address),
    body: body,
    headers: headers,
  )
      .timeout(
    const Duration(seconds: 20),
    onTimeout: () {
      return http.Response('Error', 500);
    },
  );

  return response;
}

Future<http.Response> deleteRequest(
  String url, {
  var headers,
}) async {
  final response = await http
      .delete(
    Uri.parse(url),
    headers: headers,
  )
      .timeout(
    const Duration(seconds: 20),
    onTimeout: () {
      return http.Response('Error', 500);
    },
  );

  return response;
}

uploadImage(File file, String host, String route, String name) async {
  var req = http.MultipartRequest(
    'POST',
    Uri.parse(host + route),
  );

  req.files.add(
    http.MultipartFile(
      name,
      File(file.path).readAsBytes().asStream(),
      File(file.path).lengthSync(),
      filename: file.path.split("./").last,
    ),
  );

  final response = await req.send();

  return response;
}
