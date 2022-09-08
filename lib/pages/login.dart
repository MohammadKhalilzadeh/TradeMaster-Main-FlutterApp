// It's Okay
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trader/components/alerts.dart';
import 'package:trader/components/input_fields.dart';
import 'package:trader/components/my_buttons.dart';
import 'package:trader/controllers/get_connect.dart';
import 'package:trader/controllers/getx_controller.dart';
import 'package:trader/models/user.dart';
import 'package:trader/pages/forgot_with_phone.dart';
import 'package:trader/pages/main_page.dart';
import 'package:trader/pages/policy.dart';
import 'package:trader/variables/myvariables.dart';

// ignore: use_key_in_widget_constructors
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Controller controller = Get.put(Controller());

  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    EasyLoading.addStatusCallback((status) {
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(color41),
      body: Center(
        child: ListView(
          children: [
            Center(
              child: Row(
                children: [
                  // ignore: avoid_unnecessary_containers
                  Container(
                    width: size.width * 0.4,
                    margin: EdgeInsets.all(size.width * 0.05),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(color42),
                    ),
                    child: TextButton(
                      onPressed: () {
                        controller.changeLanguage("fn", "Farsi");
                        textDirection = TextDirection.rtl;
                      },
                      child: Text(
                        "فارسی",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: fontfamily,
                        ),
                      ),
                    ),
                  ),
                  // ignore: avoid_unnecessary_containers
                  Container(
                    width: size.width * 0.4,
                    margin: EdgeInsets.all(size.width * 0.05),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(color42),
                    ),
                    child: TextButton(
                      onPressed: () {
                        controller.changeLanguage("en", "US");
                        textDirection = TextDirection.ltr;
                      },
                      child: Text(
                        "English",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: fontfamily,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(size.width * 0.05),
              child: Image.asset("assets/images/logo.png"),
            ),
            Center(
              child: Text(
                "lginfrm".tr,
                textDirection: textDirection,
                style: TextStyle(
                  color: Color(color42),
                  fontFamily: fontfamily,
                ),
              ),
            ),
            InputField(
              labelText: "phone".tr,
              fillColor: Color(color42),
              width: size.width * 0.8,
              backgroundColor: Color(color42),
              controller: phone,
              keyboardType: TextInputType.phone,
            ),
            InputField(
              labelText: "password".tr,
              width: size.width * 0.8,
              backgroundColor: Color(color42),
              fillColor: Color(color42),
              obscureText: true,
              controller: password,
              keyboardType: TextInputType.text,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 5,
                ),
                child: GestureDetector(
                  onTap: () {
                    Get.to(
                      () => const ForgotWithPhone(),
                    );
                  },
                  child: Text(
                    "forgot".tr,
                    textDirection: textDirection,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 45, 68, 87),
                      fontWeight: FontWeight.w500,
                      fontFamily: fontfamily,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            MyButton(
              width: size.width * 0.8,
              backgroundColor: Color(color42),
              color: Colors.white,
              name: "signin".tr,
              onPress: () async {
                EasyLoading.show(status: 'loading'.tr);
                final response = await postrequest(
                  host,
                  "users/loginroute/single/" + phone.text,
                  jsonEncode(
                    {
                      "password": password.text,
                    },
                  ),
                  headers: {
                    'Content-Type': 'application/json',
                  },
                ).timeout(const Duration(seconds: 15), onTimeout: () {
                  EasyLoading.showError('noresp'.tr);
                  return Future.delayed(const Duration(seconds: 45));
                });

                loader(response.statusCode);

                if (response.statusCode == 200) {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  User user = User.fromJson(jsonDecode(response.body));

                  preferences.setString("userid", user.id);
                  preferences.setString("phone", user.phone);
                  preferences.setString("token", user.token);
                  phone.text = "";
                  password.text = "";
                  Get.to(
                    () => MainScreen(
                      userid: user.id,
                      phone: user.phone,
                    ),
                  );
                }
              },
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 30,
                ),
                child: GestureDetector(
                  onTap: () {
                    Get.to(
                      () => const Policy(),
                    );
                  },
                  child: Text(
                    "mkacnt".tr,
                    textDirection: textDirection,
                    style: TextStyle(
                      color: Color(color42),
                      fontWeight: FontWeight.w500,
                      fontFamily: fontfamily,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
          ],
        ),
      ),
    );
  }
}
