import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trader/components/profile_widgets.dart';
import 'package:trader/controllers/get_connect.dart';
import 'package:trader/models/bill.dart';
import 'package:trader/pages/history_tile.dart';
import 'package:trader/variables/myvariables.dart';

class History extends StatefulWidget {
  final String phone;
  const History({
    required this.phone,
    Key? key,
  }) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(color41),
      body: FutureBuilder<List<Bill>>(
        future: getBills(
          host,
          "bills/customer/" + widget.phone,
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

  Widget historyTile(Bill bill, Size size) {
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
                bill.shopName.toString().toUpperCase() + " خرید از فروشگاه ",
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
                bill.totalPrice.toString() + " " + "ریال",
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
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    bill.dateTime.toString().length > 20
                        ? bill.dateTime.toString().substring(0, 20) + "..."
                        : bill.dateTime.toString(),
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
                        () => HistoryTile(
                          id: bill.id,
                          total: int.parse(bill.totalPrice),
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
