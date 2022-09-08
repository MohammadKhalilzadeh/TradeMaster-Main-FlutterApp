// it's okay
import 'package:flutter/material.dart';
import 'package:trader/components/alerts.dart';
import 'package:trader/controllers/get_connect.dart';
import 'package:trader/models/business.dart';
import 'package:trader/pages/mycategorylist.dart';
import 'package:trader/variables/myvariables.dart';
import 'package:get/get.dart';

class MyShop extends StatefulWidget {
  final String id;
  final String token;
  const MyShop({
    required this.id,
    required this.token,
    Key? key,
  }) : super(key: key);

  @override
  State<MyShop> createState() => _MyShopState();
}

class _MyShopState extends State<MyShop> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        bool willLeave = false;

        await myDialogBox(
          context,
          "warning".tr,
          Text(
            "logout?".tr,
            textDirection: textDirection,
          ),
          <Widget>[
            TextButton(
              onPressed: () {
                Get.back();
                Get.back();
              },
              child: Text(
                "yes".tr,
                textDirection: textDirection,
              ),
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                "Cancel".tr,
                textDirection: textDirection,
              ),
            )
          ],
        );

        return willLeave;
      },
      child: Scaffold(
        backgroundColor: Color(color41),
        body: FutureBuilder<Business>(
          future: getBusiness(host, "business/" + widget.id),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: width * 0.2,
                      ),
                      Center(
                        child: Text(
                          snapshot.data!.title.toUpperCase(),
                          style: TextStyle(
                            color: Color(color42),
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      MyCategoryList(
                        ownerid: widget.id,
                        token: widget.token,
                      ),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}
