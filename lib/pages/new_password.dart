// it's okay
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:trader/components/alerts.dart';
import 'package:trader/components/profile_widgets.dart';
import 'package:trader/controllers/get_connect.dart';
import 'package:trader/pages/login.dart';
import 'package:trader/variables/myvariables.dart';

class NewPassword extends StatefulWidget {
  final String id;
  const NewPassword({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  TextEditingController pass = TextEditingController();
  TextEditingController repass = TextEditingController();

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
              "newpassword".tr,
              pass,
              TextInputType.number,
            ),
          ),
          SizedBox(
            height: width * 0.15,
          ),
          Center(
            child: myTextField(
              width,
              "repassword".tr,
              repass,
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
              if (pass.text.isEmpty) {
                showMyDialog(context, "err".tr, "emptyfield".tr);
              } else {
                if (pass.text == repass.text) {
                  if (pass.text.length < 8) {
                    showMyDialog(context, "err".tr, "passlen".tr);
                  } else {
                    EasyLoading.show(status: 'loading'.tr);
                    final response = await patchRequest(
                      host,
                      "users/chngpass/" + widget.id,
                      jsonEncode(
                        {
                          'password': pass.text,
                        },
                      ),
                      context,
                      headers: {
                        'Content-Type': 'application/json',
                      },
                    );

                    loader(response.statusCode);

                    if (response.statusCode == 200) {
                      Get.to(
                        () => LoginScreen(),
                      );
                    }
                  }
                } else {
                  showMyDialog(context, "err".tr, "uneqlpass".tr);
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
