import 'dart:convert';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:trader/components/alerts.dart';
import 'package:trader/components/profile_widgets.dart';
import 'package:trader/controllers/get_connect.dart';
import 'package:trader/models/payreq.dart';
import 'package:trader/variables/myvariables.dart';
import 'package:get/get.dart';

class PayForCart extends StatefulWidget {
  final String shopname;
  final String shopid;
  final int itemscost;
  final int delivery;
  final int total;
  const PayForCart({
    required this.shopid,
    required this.shopname,
    required this.itemscost,
    required this.delivery,
    required this.total,
    Key? key,
  }) : super(key: key);

  @override
  State<PayForCart> createState() => _PayForCartState();
}

class _PayForCartState extends State<PayForCart> {
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();

  Future<void> launchInBrowser(String url) async {
    Future.delayed(const Duration(milliseconds: 5000), () {});
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalNonBrowserApplication,
      webViewConfiguration: const WebViewConfiguration(enableJavaScript: true),
    )) {
      throw showMyDialog(context, "Error", "Failed to Open");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(color41),
      body: ListView(
        children: [
          SizedBox(
            height: size.height * 0.075,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Text(
                " خرید از فروشگاه " + widget.shopname.toUpperCase(),
                textDirection: textDirection,
                style: TextStyle(
                  color: Color(color42),
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          priceshow(
            "قیمت کل اقلام",
            widget.itemscost.toString() + " " + "curncy".tr,
          ),
          priceshow(
            "هزینه پیک",
            widget.delivery.toString() + " " + "curncy".tr,
          ),
          priceshow(
            "هزینه کل",
            widget.total.toString() + " " + "curncy".tr,
          ),
          Center(
            child: myTextField(
              size.width * 0.8,
              "شماره موبایل شما",
              phone,
              TextInputType.number,
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Center(
            child: myTextField(
              size.width * 0.8,
              "آدرس خود را بنویسید",
              address,
              TextInputType.text,
              maxline: 8,
            ),
          ),
          const Divider(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: size.width * 0.6,
              child: myButton(
                size.width * 0.6,
                " پرداخت ",
                () async {
                  if (phone.text.isEmpty || address.text.isEmpty) {
                    showMyDialog(context, "خطا",
                        "شماره تلفن و آدرس نمی‌تواند خالی باشد");
                  } else {
                    EasyLoading.show(status: 'loading'.tr);
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    Jalali jalali = Jalali.now();
                    final response = await postrequest(
                      host,
                      "bills",
                      jsonEncode(
                        <String, dynamic>{
                          "TotalPrice": widget.total,
                          "CustomerPhone": phone.text,
                          "PartnerShare": widget.total * 0.9,
                          "ShopName": widget.shopname,
                          "CustomerAddress": address.text,
                          "owner": widget.shopid,
                          "items": myshoppingcart.toSet().toList(),
                          "Datetime": jalali.year.toString() +
                              "-" +
                              jalali.month.toString() +
                              "-" +
                              jalali.day.toString() +
                              ":" +
                              jalali.hour.toString() +
                              "-" +
                              jalali.day.toString(),
                        },
                      ),
                      headers: {
                        'Content-Type': 'application/json; charset=UTF-8',
                        'Authorization':
                            'Bearer ' + preferences.getString("token")!,
                      },
                    );

                    loader(response.statusCode);

                    if (response.statusCode == 200) {
                      PayReq payReq = payReqFromJson(response.body);
                      if (payReq.status == 100) {
                        launchInBrowser(payReq.url);
                      } else {
                        showMyDialog(
                            context, payReq.status.toString(), "Error");
                      }
                      Get.back();
                      Get.back();
                      Get.back();
                      Get.back();
                      myshoppingcart.clear();
                    }
                  }
                },
                Color(color42),
                Color(color42),
                Color(color41),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget priceshow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        textDirection: textDirection,
        children: [
          Text(
            label,
            textDirection: textDirection,
            style: TextStyle(
              color: Color(color42).withOpacity(0.8),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            textDirection: textDirection,
            style: TextStyle(
              color: Color(color42).withOpacity(0.8),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
