import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trader/components/alerts.dart';
import 'package:trader/components/menu_btn.dart';
import 'package:trader/pages/choose_location.dart';
import 'package:trader/pages/history.dart';
import 'package:trader/pages/profile.dart';
import 'package:trader/pages/wp.dart';
import 'package:trader/variables/myvariables.dart';

class MyMenu extends StatelessWidget {
  final String phone;
  const MyMenu({
    required this.phone,
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.5,
      color: Color(color42).withOpacity(0.6),
      child: ListView(
        children: [
          MenuBtn(
            name: "reqs",
            iconData: Icons.add_box_rounded,
            ontap: () {
              Get.to(
                () => const ChooseLocation(),
              );
            },
          ),
          MenuBtn(
            name: "orders",
            iconData: Icons.history,
            ontap: () {
              Get.to(
                () => History(
                  phone: phone,
                ),
              );
            },
          ),
          MenuBtn(
            name: "identify",
            iconData: Icons.person,
            ontap: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();

              Get.to(
                () => Profile(
                  userid: preferences.getString('userid')!,
                ),
              );
            },
          ),
          MenuBtn(
            name: "exit",
            iconData: Icons.logout,
            ontap: () async {
              await myDialogBox(
                context,
                "err".tr,
                Text(
                  "logout?".tr,
                  textDirection: textDirection,
                ),
                <Widget>[
                  TextButton(
                    onPressed: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      preferences.clear();
                      Get.back(
                        closeOverlays: true,
                        canPop: true,
                      );
                      Get.back();
                      Get.back();
                      Get.back();
                      Get.to(
                        () => const WelcomePage(),
                      );
                    },
                    child: Text("nxt".tr),
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
          ),
        ],
      ),
    );
  }
}
