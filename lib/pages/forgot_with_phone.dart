// it's okay
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:trader/components/alerts.dart';
import 'package:trader/components/profile_widgets.dart';
import 'package:trader/controllers/get_connect.dart';
import 'package:trader/pages/phone_confirm.dart';
import 'package:trader/variables/myvariables.dart';

class ForgotWithPhone extends StatefulWidget {
  const ForgotWithPhone({Key? key}) : super(key: key);

  @override
  State<ForgotWithPhone> createState() => _ForgotWithPhoneState();
}

class _ForgotWithPhoneState extends State<ForgotWithPhone> {
  TextEditingController phone = TextEditingController();

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
              "enterphonemsg".tr,
              style: TextStyle(
                color: Color(color42),
                fontFamily: fontfamily,
              ),
            ),
          ),
          Center(
            child: myTextField(
              width,
              "phone".tr,
              phone,
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
              if (phone.text.isEmpty) {
                showMyDialog(context, "err".tr, "emptyfield".tr);
              } else {
                EasyLoading.show(status: 'loading'.tr);
                final response =
                    await postrequest(host, "users/getcode/" + phone.text, {});

                loader(response.statusCode);
                if (response.statusCode == 200) {
                  Get.to(
                    () => PhoneConfirm(
                      phone: phone.text,
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
