import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trader/components/alerts.dart';
import 'package:trader/components/customed_btn.dart';
import 'package:trader/controllers/get_connect.dart';
import 'package:trader/models/item.dart';
import 'package:trader/pages/image_uploader.dart';
import 'package:trader/variables/myvariables.dart';

class EditItem extends StatefulWidget {
  final String itemid;
  const EditItem({
    required this.itemid,
    Key? key,
  }) : super(key: key);

  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  TextEditingController price = TextEditingController();
  TextEditingController desc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(color41),
      body: FutureBuilder<Item>(
        future: getItem(
          host,
          "items/" + widget.itemid,
        ),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 16),
                            blurRadius: 20,
                            color: const Color(0xff7090b0).withAlpha(51),
                          ),
                        ],
                      ),
                      width: size.width,
                      height: size.height * 0.4,
                      child: snapshot.data!.images.isNotEmpty
                          ? Image.network(
                              host + "images/items/" + snapshot.data!.images[0],
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              "assets/images/holder.png",
                              fit: BoxFit.cover,
                              width: size.width * 0.4,
                              height: size.height,
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        textDirection: textDirection,
                        children: [
                          Text(
                            "itemimgs".tr,
                            textDirection: textDirection,
                            style: TextStyle(
                              fontSize: 24,
                              color: Color(color42),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Get.to(
                                () => UploadImage(
                                  dest: "items/image/" + widget.itemid,
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.add_box,
                              size: 30,
                              color: Color(color42),
                            ),
                          ),
                        ],
                      ),
                    ),
                    snapshot.data!.images.isNotEmpty
                        ? Container(
                            decoration: const BoxDecoration(),
                            height: 150,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.images.length,
                              itemBuilder: (context, index) {
                                return imageCard(snapshot.data!.images[index],
                                    size.width * 0.31);
                              },
                            ),
                          )
                        : const Center(),
                    const Divider(
                      height: 10,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "editables".tr,
                          style: const TextStyle(
                            fontSize: 26,
                          ),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          settingButton(
                            snapshot.data!.isavailable == true
                                ? "available".tr
                                : "notavailable".tr,
                            Icons.inventory,
                            () async {
                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              myDialogBox(
                                context,
                                "inventory".tr,
                                Text("choosevalue".tr),
                                <Widget>[
                                  TextButton(
                                    onPressed: () async {
                                      EasyLoading.show(status: 'loading'.tr);
                                      final response = await patchRequest(
                                        host,
                                        "items/" + widget.itemid,
                                        jsonEncode(
                                          {
                                            'isavailable': true,
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
                                        setState(() {});
                                      }
                                    },
                                    child: Text("available".tr),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      EasyLoading.show(status: 'loading'.tr);
                                      final response = await patchRequest(
                                        host,
                                        "items/" + snapshot.data!.id,
                                        jsonEncode(
                                          {
                                            'isavailable': false,
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
                                        setState(() {});
                                      }
                                    },
                                    child: Text("notavailable".tr),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text("Cancel".tr),
                                  ),
                                ],
                              );
                              setState(() {});
                            },
                          ),
                          settingButton(
                            snapshot.data!.price,
                            Icons.price_check,
                            () async {
                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();

                              myDialogBox(
                                context,
                                "editprice".tr,
                                TextField(
                                  controller: price,
                                  decoration: InputDecoration(
                                    hintText: "newval".tr,
                                  ),
                                ),
                                <Widget>[
                                  TextButton(
                                    onPressed: () async {
                                      EasyLoading.show(status: 'loading'.tr);
                                      final response = await patchRequest(
                                        host,
                                        "items/" + snapshot.data!.id,
                                        jsonEncode(
                                          {
                                            'price': price.text,
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
                                        setState(() {});
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
                              setState(() {});
                            },
                          ),
                          settingButton(
                            snapshot.data!.description,
                            Icons.description,
                            () async {
                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              myDialogBox(
                                context,
                                "editdesc".tr,
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
                                      final response = await patchRequest(
                                        host,
                                        "items/" + snapshot.data!.id,
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
                                        setState(() {});
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
                              setState(() {});
                            },
                          ),
                          settingButton(
                            (snapshot.data!.unit == "Count" ? "تعداد" : "وزن") +
                                " " * 10,
                            Icons.line_weight,
                            () async {
                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              myDialogBox(
                                context,
                                "editunit".tr,
                                const Center(),
                                <Widget>[
                                  TextButton(
                                    onPressed: () async {
                                      EasyLoading.show(status: 'loading'.tr);
                                      final response = await patchRequest(
                                        host,
                                        "items/" + snapshot.data!.id,
                                        jsonEncode(
                                          {
                                            'unit': "Weight",
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
                                        setState(() {});
                                      }
                                    },
                                    child: Text("weight".tr),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      EasyLoading.show(status: 'loading'.tr);
                                      final response = await patchRequest(
                                        host,
                                        "items/" + snapshot.data!.id,
                                        jsonEncode(
                                          {
                                            'unit': "Count",
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
                                        setState(() {});
                                      }
                                    },
                                    child: Text("count".tr),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text("Cancel".tr),
                                  ),
                                ],
                              );
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 10,
                    ),
                    snapshot.data!.colors.isNotEmpty
                        ? Center(
                            child: Text(
                              "colors".tr,
                              style: const TextStyle(
                                fontSize: 26,
                              ),
                            ),
                          )
                        : const Center(),
                    snapshot.data!.colors.isNotEmpty
                        ? SizedBox(
                            height: size.height * 0.1,
                            child: ListView.builder(
                              itemCount: snapshot.data!.colors.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return listItem(
                                  snapshot.data!.colors,
                                  index,
                                  size,
                                );
                              },
                            ),
                          )
                        : const Center(),
                    const Divider(
                      height: 10,
                    ),
                    snapshot.data!.sizes.isNotEmpty
                        ? Center(
                            child: Text(
                              "sizes".tr,
                              style: const TextStyle(
                                fontSize: 26,
                              ),
                            ),
                          )
                        : const Center(),
                    snapshot.data!.sizes.isNotEmpty
                        ? SizedBox(
                            height: size.height * 0.1,
                            child: ListView.builder(
                              itemCount: snapshot.data!.sizes.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return listItem(
                                  snapshot.data!.sizes,
                                  index,
                                  size,
                                );
                              },
                            ),
                          )
                        : const Center(),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }

  Widget imageCard(String address, double width) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onLongPress: () {},
        child: SizedBox(
          width: width,
          height: 120,
          child: Image.network(
            host + "images/items/" + address,
          ),
        ),
      ),
    );
  }

  Widget listItem(List<dynamic> snapshot, int index, Size size) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: size.width * 0.25,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(color42),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              snapshot[index].toString().toUpperCase(),
              style: TextStyle(
                color: Color(color41),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
