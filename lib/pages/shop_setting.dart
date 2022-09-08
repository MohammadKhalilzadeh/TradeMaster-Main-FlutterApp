// it's okay
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trader/components/alerts.dart';
import 'package:trader/components/customed_btn.dart';
import 'package:trader/controllers/get_connect.dart';
import 'package:trader/models/business.dart';
import 'package:trader/pages/image_uploader.dart';
import 'package:trader/variables/myvariables.dart';

class ShopSetting extends StatefulWidget {
  final String shopid;
  const ShopSetting({
    required this.shopid,
    Key? key,
  }) : super(key: key);

  @override
  State<ShopSetting> createState() => _ShopSettingState();
}

class _ShopSettingState extends State<ShopSetting> {
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController delivery = TextEditingController();

  File? file;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(color41),
      body: FutureBuilder<Business>(
        future: getBusiness(host, "business/" + widget.shopid),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView(
                  children: [
                    Container(
                      height: size.height * 0.4,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 8),
                            blurRadius: 20,
                            color: const Color(0xff7090b0).withAlpha(20),
                          ),
                        ],
                      ),
                      child: snapshot.data!.imgs.isEmpty
                          ? Center(
                              child: IconButton(
                                onPressed: () {
                                  Get.to(
                                    () => UploadImage(
                                      dest: "business/image/" + widget.shopid,
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.image,
                                  size: 60,
                                ),
                              ),
                            )
                          : Image.network(
                              host +
                                  "images/businesses/" +
                                  snapshot.data!.imgs[0],
                              fit: BoxFit.cover,
                            ),
                    ),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "editables".tr,
                          style: TextStyle(
                            color: Color(color42),
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          settingButton(
                            snapshot.data!.phone,
                            Icons.phone,
                            () {
                              myDialogBox(
                                context,
                                snapshot.data!.phone,
                                TextField(
                                  controller: phone,
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
                                        "business/" + snapshot.data!.id,
                                        jsonEncode(
                                          {
                                            'phone': phone.text,
                                          },
                                        ),
                                        context,
                                        headers: {
                                          'Content-Type': 'application/json',
                                          'Authorization': 'Bearer ' +
                                              preferences.getString("token")!,
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
                          ),
                          settingButton(
                            snapshot.data!.email,
                            Icons.email,
                            () {
                              myDialogBox(
                                context,
                                snapshot.data!.email,
                                TextField(
                                  controller: email,
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
                                        "business/" + snapshot.data!.id,
                                        jsonEncode(
                                          {
                                            'email': email.text,
                                          },
                                        ),
                                        context,
                                        headers: {
                                          'Content-Type': 'application/json',
                                          'Authorization': 'Bearer ' +
                                              preferences.getString("token")!,
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
                          ),
                          settingButton(
                            snapshot.data!.description,
                            Icons.description,
                            () {
                              myDialogBox(
                                context,
                                snapshot.data!.description,
                                TextField(
                                  controller: desc,
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
                                        "business/" + snapshot.data!.id,
                                        jsonEncode(
                                          {
                                            'description': desc.text,
                                          },
                                        ),
                                        context,
                                        headers: {
                                          'Content-Type': 'application/json',
                                          'Authorization': 'Bearer ' +
                                              preferences.getString("token")!,
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
                          ),
                          settingButton(
                            snapshot.data!.delivery.toString() +
                                " " +
                                "curncy".tr,
                            Icons.delivery_dining,
                            () {
                              myDialogBox(
                                context,
                                snapshot.data!.delivery.toString(),
                                TextField(
                                  controller: delivery,
                                  textDirection: textDirection,
                                  decoration:
                                      InputDecoration(hintText: "newval".tr),
                                ),
                                <Widget>[
                                  TextButton(
                                    onPressed: () async {
                                      EasyLoading.show(status: 'loading'.tr);
                                      SharedPreferences preferences =
                                          await SharedPreferences.getInstance();
                                      final response = await patchRequest(
                                        host,
                                        "business/" + snapshot.data!.id,
                                        jsonEncode(
                                          {
                                            'delivery': delivery.text,
                                          },
                                        ),
                                        context,
                                        headers: {
                                          'Content-Type': 'application/json',
                                          'Authorization': 'Bearer ' +
                                              preferences.getString("token")!,
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
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "Your Address".tr,
                          textDirection: textDirection,
                          style: TextStyle(
                            color: Color(color42),
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                        bottom: 20,
                        left: 25,
                        right: 25,
                      ),
                      child: Text(
                        snapshot.data!.address,
                        textDirection: textDirection,
                        style: TextStyle(
                          color: Color(color42).withOpacity(0.8),
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
