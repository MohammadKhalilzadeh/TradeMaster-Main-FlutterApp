// It's Okay
import 'package:flutter/material.dart';
import 'package:trader/components/profile_widgets.dart';
import 'package:trader/pages/ipv4.dart';
import 'package:trader/variables/myvariables.dart';
import 'package:get/get.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(color41),
      body: ListView(
        children: [
          SizedBox(
            height: size.height * 0.05,
          ),
          Center(
            child: SizedBox(
              width: size.width * 0.8,
              child: Image.asset("assets/images/logo.png"),
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "moto".tr,
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: fontfamily,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: size.width * 0.1,
              right: size.width * 0.1,
              bottom: 20,
            ),
            child: myButton(
              size.width * 0.8,
              "signup".tr,
              () {
                // Get.to(() => const Policy());
                Get.to(
                  () => const IPv4(
                    hasOne: false,
                  ),
                );
              },
              Color(color42),
              Color(color42),
              Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: size.width * 0.1,
              right: size.width * 0.1,
              bottom: 20,
            ),
            child: myButton(
              size.width * 0.8,
              "amember".tr,
              () {
                // Get.to(() => LoginScreen());
                Get.to(
                  () => const IPv4(
                    hasOne: true,
                  ),
                );
              },
              Color(color41),
              Color(color42),
              Color(color42),
            ),
          ),
        ],
      ),
    );
  }
}
