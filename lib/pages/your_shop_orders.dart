import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trader/components/profile_widgets.dart';
import 'package:trader/controllers/get_connect.dart';
import 'package:trader/models/bill.dart';
import 'package:trader/pages/order.details.dart';
import 'package:trader/variables/myvariables.dart';

class MyShopOrders extends StatelessWidget {
  final String shopid;
  const MyShopOrders({
    required this.shopid,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(color41),
      body: FutureBuilder<List<Bill>>(
        future: getBills(
          host,
          "bills/shoporders/" + shopid,
        ),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return snapshot.data!.isNotEmpty
                        ? historyTile(
                            snapshot.data![index],
                            size,
                            context,
                          )
                        : Center(
                            child: Text("emptylist".tr),
                          );
                  },
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }

  Widget historyTile(Bill bill, Size size, BuildContext context) {
    String status = "";
    late Color statusColor;
    if (bill.status == "Pending") {
      status = "در انتظار";
      statusColor = Colors.orange;
    } else if (bill.status == "Seen") {
      status = "در حال رسیدگی";
      statusColor = Colors.blue;
    } else if (bill.status == "On way") {
      status = "ارسال شده";
      statusColor = Colors.indigoAccent;
    } else if (bill.status == "Delivered") {
      status = "تحویل داده شده";
      statusColor = Colors.green;
    } else if (bill.status == "Failed") {
      status = "لغو شده";
      statusColor = Colors.red;
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: textDirection,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 5,
                left: 25,
                right: 25,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    status,
                    textDirection: textDirection,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 2,
                left: 25,
                right: 25,
              ),
              child: Text(
                " خرید از فروشگاه " + bill.shopName.toString().toUpperCase(),
                textDirection: textDirection,
                style: TextStyle(
                  color: Color(color42),
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 2,
                bottom: 5,
                left: 25,
                right: 25,
              ),
              child: Text(
                bill.totalPrice.toString() + " " + "curncy".tr,
                textDirection: textDirection,
                style: TextStyle(
                  color: Color(color42).withOpacity(0.6),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 2,
                left: 25,
                right: 25,
              ),
              child: Text(
                "تحویل سفارش به",
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
                bottom: 10,
                left: 25,
                right: 25,
              ),
              child: Text(
                bill.customerAddress.toString(),
                textDirection: textDirection,
                style: TextStyle(
                  color: Color(color42).withOpacity(0.8),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 5,
                bottom: 5,
                left: 25,
                right: 25,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bill.dateTime.toString(),
                    textDirection: textDirection,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  myButton(
                    size.width * 0.6,
                    "جزئیات فاکتور",
                    () {
                      Get.to(
                        () => OrderDetails(
                          id: bill.id,
                          customerAddress: bill.customerAddress,
                          customerPhone: bill.customerPhone,
                          status: bill.status,
                        ),
                      );
                    },
                    Color(color42),
                    Color(color42),
                    Color(color41),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
