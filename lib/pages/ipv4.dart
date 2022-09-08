import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trader/components/alerts.dart';
import 'package:trader/components/profile_widgets.dart';
import 'package:trader/pages/login.dart';
import 'package:trader/pages/policy.dart';
import 'package:trader/variables/myvariables.dart';

class IPv4 extends StatefulWidget {
  final bool hasOne;
  const IPv4({
    required this.hasOne,
    Key? key,
  }) : super(key: key);

  @override
  State<IPv4> createState() => _IPv4State();
}

class _IPv4State extends State<IPv4> {
  @override
  Widget build(BuildContext context) {
    TextEditingController ipv4 = TextEditingController();

    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(color41),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(width * 0.1),
            child: Text(
              "ipv4msg".tr,
              style: TextStyle(
                color: Color(color42),
                fontFamily: fontfamily,
              ),
            ),
          ),
          Center(
            child: myTextField(
              width,
              "ipv4".tr,
              ipv4,
              TextInputType.number,
            ),
          ),
          SizedBox(
            height: width * 0.05,
          ),
          myButton(
            width * 0.8,
            "nxt".tr,
            () async {
              if (ipv4.text.isEmpty) {
                showMyDialog(context, "err".tr, "emptyfield".tr);
              } else {
                if (widget.hasOne == true) {
                  setState(() {
                    address = ipv4.text;
                  });
                  Get.to(() => LoginScreen());
                } else {
                  setState(() {
                    address = ipv4.text;
                  });
                  Get.to(() => const Policy());
                }
              }
            },
            Color(color42),
            Color(color42),
            Color(color41),
          ),
        ],
      ),
    );
  }
}
