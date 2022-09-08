// it's okay
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:trader/components/alerts.dart';
import 'package:trader/components/profile_widgets.dart';
import 'package:trader/controllers/get_connect.dart';
import 'package:trader/models/user.dart';
import 'package:trader/pages/new_password.dart';
import 'package:trader/variables/myvariables.dart';
import 'package:get/get.dart';

class PhoneConfirm extends StatefulWidget {
  final String phone;
  const PhoneConfirm({
    required this.phone,
    Key? key,
  }) : super(key: key);

  @override
  State<PhoneConfirm> createState() => _PhoneConfirmState();
}

class _PhoneConfirmState extends State<PhoneConfirm> {
  TextEditingController code = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              "confmsg".tr,
              style: TextStyle(
                color: Color(color42),
                fontFamily: fontfamily,
              ),
            ),
          ),
          Center(
            child: myTextField(
              width,
              "confcode".tr,
              code,
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
              if (code.text.isEmpty) {
                showMyDialog(context, "err".tr, "emptyfield".tr);
              } else {
                EasyLoading.show(status: 'loading'.tr);
                final response = await postrequest(
                  host,
                  "users/chkcode/" + widget.phone,
                  jsonEncode({
                    'code': code.text,
                  }),
                  headers: {
                    'Content-Type': 'application/json',
                  },
                );

                loader(response.statusCode);
                if (response.statusCode == 200) {
                  User user = User.fromJson(jsonDecode(response.body));

                  Get.to(
                    () => NewPassword(
                      id: user.id,
                    ),
                  );
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
