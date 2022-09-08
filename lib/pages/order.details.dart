import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trader/components/alerts.dart';
import 'package:trader/components/profile_widgets.dart';
import 'package:trader/controllers/get_connect.dart';
import 'package:trader/models/mypick.dart';
import 'package:trader/variables/myvariables.dart';
import 'package:get/get.dart';

class OrderDetails extends StatefulWidget {
  final String id;
  final String customerAddress;
  final String customerPhone;
  final String status;
  const OrderDetails({
    required this.id,
    required this.customerAddress,
    required this.customerPhone,
    required this.status,
    Key? key,
  }) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(color41),
      body: FutureBuilder<List<MyPick>>(
        future: billPicks(host, "bills/" + widget.id),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView(
                  children: [
                    widget.status == "On The Way"
                        ? const Center()
                        : Padding(
                            padding: const EdgeInsets.all(20),
                            child: myButton(
                              size.width * 0.8,
                              "تغییر وضعیت",
                              () async {
                                String status = "";
                                if (widget.status == "Pending") {
                                  status = "Preparing";
                                } else if (widget.status == "Preparing") {
                                  status = "On Way";
                                } else if (widget.status == "On Way") {
                                  status = "Delivered";
                                }
                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                EasyLoading.show(status: 'loading'.tr);
                                final response = await patchRequest(
                                  host,
                                  "bills/billstatus/" + widget.id,
                                  jsonEncode(
                                    {
                                      "Status": status,
                                    },
                                  ),
                                  context,
                                  headers: {
                                    'Content-Type': 'application/json',
                                    'Authorization': 'Bearer ' +
                                        preferences.getString("token")!,
                                  },
                                );
                                loader(response.statusCode);
                                if (response.statusCode == 200) {
                                  setState(() {});
                                  Get.back();
                                  setState(() {});
                                }
                              },
                              Color(color42),
                              Color(color42),
                              Color(color41),
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(color42),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: size.height * 0.5,
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                top: 20,
                                bottom: 5,
                                left: 30,
                                right: 30,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                textDirection: textDirection,
                                children: [
                                  Text(
                                    snapshot.data![index].name,
                                    textDirection: textDirection,
                                  ),
                                  Text(
                                    snapshot.data![index].amount.toString(),
                                    textDirection: textDirection,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        bottom: 20,
                        left: 40,
                        right: 40,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        textDirection: textDirection,
                        children: [
                          Text(
                            "تلفن مشتری",
                            textDirection: textDirection,
                          ),
                          Text(
                            widget.customerPhone,
                            textDirection: textDirection,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        bottom: 2,
                        left: 40,
                        right: 40,
                      ),
                      child: Text(
                        "تحویل سفارش به آدرس:",
                        textDirection: textDirection,
                        style: TextStyle(
                          color: Color(color42).withOpacity(0.8),
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 2,
                        bottom: 20,
                        left: 40,
                        right: 40,
                      ),
                      child: Text(
                        widget.customerAddress.toString(),
                        textDirection: textDirection,
                        style: TextStyle(
                          color: Color(color42).withOpacity(0.8),
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
