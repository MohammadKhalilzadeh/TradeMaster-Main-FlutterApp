import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trader/components/alerts.dart';
import 'package:trader/controllers/get_connect.dart';
import 'package:trader/pages/forgot_with_phone.dart';
import 'package:trader/variables/myvariables.dart';
import 'package:get/get.dart';

Widget userGeneralInfo(
  double width,
  BuildContext context,
  String phone,
  String email,
  String password,
) {
  TextEditingController phoneC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  return Container(
    width: width * 0.9,
    padding: EdgeInsets.all(width * 0.05),
    decoration: BoxDecoration(
      color: Color(color41),
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(60),
          spreadRadius: 3,
          blurRadius: 3, // changes position of shadow
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () {
            myDialogBox(
              context,
              phone,
              TextField(
                controller: phoneC,
                textDirection: textDirection,
                decoration: InputDecoration(
                  hintText: "newval".tr,
                ),
              ),
              <Widget>[
                TextButton(
                  onPressed: () async {
                    EasyLoading.show(status: 'loading'.tr);
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    final response = await patchRequest(
                      host,
                      "users/ident/" + preferences.getString("userid")!,
                      jsonEncode(
                        {
                          'phone': phoneC.text,
                        },
                      ),
                      context,
                      headers: {
                        'Content-Type': 'application/json',
                        'Authorization':
                            'Bearer ' + preferences.getString("token")!,
                      },
                    ).catchError((err) {
                      // print(err);
                    });

                    loader(response.statusCode);

                    if (response.statusCode == 200) {
                      Get.back();
                    }
                  },
                  child: Text("update".tr),
                ),
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("Cancel".tr),
                ),
              ],
            );
          },
          icon: Icon(
            Icons.phone,
            color: Color(color42),
            size: 30,
          ),
        ),
        IconButton(
          onPressed: () {
            myDialogBox(
              context,
              email,
              TextField(
                controller: emailC,
                textDirection: textDirection,
                decoration: InputDecoration(
                  hintText: "newval".tr,
                ),
              ),
              <Widget>[
                TextButton(
                  onPressed: () async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    final response = await patchRequest(
                      host,
                      "users/ident/" + preferences.getString("userid")!,
                      jsonEncode(
                        {
                          'email': emailC.text,
                        },
                      ),
                      context,
                      headers: {
                        'Content-Type': 'application/json',
                        'Authorization':
                            'Bearer ' + preferences.getString("token")!,
                      },
                    );

                    loader(response.statusCode);
                    if (response.statusCode == 200) {
                      Get.back();
                    }
                  },
                  child: Text("update".tr),
                ),
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("Cancel".tr),
                ),
              ],
            );
          },
          icon: Icon(
            Icons.email,
            color: Color(color42),
            size: 30,
          ),
        ),
        IconButton(
          onPressed: () {
            Get.to(
              () => const ForgotWithPhone(),
            );
          },
          icon: Icon(
            Icons.password,
            color: Color(color42),
            size: 30,
          ),
        ),
      ],
    ),
  );
}

Widget shebaField(double width, TextEditingController sheba, String shebaNo) {
  return shebaNo == '-'
      ? Container(
          width: width * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(color41),
            border: Border.all(
              color: Color(color42),
            ),
          ),
          child: TextField(
            controller: sheba,
            textDirection: textDirection,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(color42),
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'sheba'.tr,
              labelStyle: TextStyle(
                color: Color(color42),
                fontFamily: fontfamily,
              ),
              hintStyle: TextStyle(
                color: Color(color42),
                fontFamily: fontfamily,
              ),
            ),
          ),
        )
      : Text(shebaNo);
}

Widget cardField(double width, TextEditingController card, int credit) {
  return credit == 0
      ? Container(
          width: width * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(color41),
            border: Border.all(
              color: Color(color42),
            ),
          ),
          child: TextField(
            controller: card,
            textDirection: textDirection,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(color42),
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'card'.tr,
              labelStyle: TextStyle(
                color: Color(color42),
                fontFamily: fontfamily,
              ),
              hintStyle: TextStyle(
                color: Color(color42),
                fontFamily: fontfamily,
              ),
            ),
          ),
        )
      : Text(credit.toString());
}

Widget addressField(
  double width,
  TextEditingController contr,
  String hint,
  dynamic value, {
  int? lines,
  TextInputType? keyboardType,
}) {
  return value == '-' || value == 0
      ? Container(
          width: width * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(color41),
            border: Border.all(
              color: Color(color42),
            ),
          ),
          child: TextField(
            controller: contr,
            maxLines: lines,
            textDirection: textDirection,
            keyboardType: keyboardType,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(color42),
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              labelStyle: TextStyle(
                color: Color(color42),
                fontFamily: fontfamily,
              ),
              hintStyle: TextStyle(
                color: Color(color42),
                fontFamily: fontfamily,
              ),
            ),
          ),
        )
      : Text(
          value.toString(),
        );
}

Container myTextField(double width, String name,
    TextEditingController controller, TextInputType inputType,
    {int? maxline}) {
  return Container(
    width: width * 0.9,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Color(color41),
      border: Border.all(
        color: Color(color42),
      ),
    ),
    child: TextField(
      controller: controller,
      textAlign: TextAlign.center,
      maxLines: maxline,
      keyboardType: inputType,
      textDirection: textDirection,
      style: TextStyle(
        color: Color(color42),
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: name,
        labelStyle: TextStyle(
          color: Color(color42),
          fontFamily: fontfamily,
        ),
        hintStyle: TextStyle(
          color: Color(color42),
          fontFamily: fontfamily,
        ),
      ),
    ),
  );
}

Container myButton(
  double width,
  String name,
  VoidCallback onPress,
  Color color1,
  Color color2,
  Color color3,
) {
  return Container(
    width: width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: color1,
      border: Border.all(
        color: color2,
      ),
    ),
    child: TextButton(
      onPressed: onPress,
      child: Text(
        name,
        textDirection: textDirection,
        style: TextStyle(
          color: color3,
          fontFamily: fontfamily,
        ),
      ),
    ),
  );
}
