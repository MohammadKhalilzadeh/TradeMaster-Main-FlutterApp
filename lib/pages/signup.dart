// it's okay
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trader/components/alerts.dart';
import 'package:trader/components/input_fields.dart';
import 'package:trader/components/my_buttons.dart';
import 'package:trader/models/user.dart';
import 'package:trader/pages/login.dart';
import 'package:trader/variables/myvariables.dart';
import '../controllers/get_connect.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController repassword = TextEditingController();
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
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(size.width * 0.1),
            child: Image.asset("assets/images/logo.png"),
          ),
          Center(
            child: Text(
              "mkacnt".tr,
              style: TextStyle(
                color: Color(color42),
                fontFamily: fontfamily,
              ),
            ),
          ),
          InputField(
            labelText: "firstname".tr,
            fillColor: Color(color31),
            width: size.width * 0.8,
            backgroundColor: Color(color42),
            keyboardType: TextInputType.text,
            controller: firstname,
          ),
          InputField(
            labelText: "lastname".tr,
            width: size.width * 0.8,
            backgroundColor: Color(color42),
            fillColor: Color(color42),
            keyboardType: TextInputType.text,
            controller: lastname,
          ),
          InputField(
            labelText: "phone".tr,
            fillColor: Color(color42),
            width: size.width * 0.8,
            backgroundColor: Color(color42),
            keyboardType: TextInputType.phone,
            controller: phone,
          ),
          InputField(
            labelText: "email".tr,
            width: size.width * 0.8,
            backgroundColor: Color(color42),
            fillColor: Color(color42),
            keyboardType: TextInputType.emailAddress,
            controller: email,
          ),
          InputField(
            labelText: "password".tr,
            fillColor: Color(color42),
            width: size.width * 0.8,
            backgroundColor: Color(color42),
            obscureText: true,
            controller: password,
          ),
          InputField(
            labelText: "repassword".tr,
            width: size.width * 0.8,
            backgroundColor: Color(color42),
            fillColor: Color(color42),
            obscureText: true,
            controller: repassword,
          ),
          SizedBox(
            height: size.width * 0.1,
          ),
          MyButton(
            width: size.width * 0.8,
            backgroundColor: Color(color42),
            color: Colors.white,
            name: "signup".tr,
            onPress: () async {
              if (firstname.text.isEmpty ||
                  lastname.text.isEmpty ||
                  email.text.isEmpty ||
                  phone.text.isEmpty ||
                  password.text.isEmpty) {
                showMyDialog(context, "err".tr, "emptyfield".tr);
              } else {
                if (password.text.length >= 8) {
                  if (password.text == repassword.text) {
                    EasyLoading.show(status: 'loading'.tr);
                    final response = await postrequest(
                      host,
                      "users",
                      jsonEncode(
                        {
                          "firstname": firstname.text,
                          "lastname": lastname.text,
                          "email": email.text,
                          "password": password.text,
                          "phone": phone.text,
                        },
                      ),
                      headers: {
                        'Content-Type': 'application/json',
                      },
                    )
                        .catchError(
                          (err) {},
                        )
                        .timeout(
                          const Duration(seconds: 20),
                        );

                    loader(response.statusCode);

                    if (response.statusCode == 200) {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      User user = User.fromJson(jsonDecode(response.body));
                      preferences.setString("userid", user.id);
                      firstname.text = "";
                      lastname.text = "";
                      phone.text = "";
                      email.text = "";
                      password.text = "";
                      repassword.text = "";

                      Get.to(
                        () => LoginScreen(),
                      );
                    }
                  } else {
                    showMyDialog(context, "err".tr, "uneqlpass".tr);
                  }
                } else {
                  showMyDialog(context, "err".tr, "passlen".tr);
                }
              }
            },
          ),
          Padding(
            padding: EdgeInsets.all(size.width * 0.1),
            child: SizedBox(
              width: size.width * 0.8,
              child: Divider(
                color: Color(color42),
              ),
            ),
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
                    () => LoginScreen(),
                  );
                },
                child: Text(
                  "amember".tr,
                  style: TextStyle(
                    color: Color(color42),
                    fontWeight: FontWeight.w500,
                    fontFamily: fontfamily,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
