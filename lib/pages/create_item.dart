import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trader/components/alerts.dart';
import 'package:trader/components/input_fields.dart';
import 'package:trader/components/profile_widgets.dart';
import 'package:trader/controllers/get_connect.dart';
import 'package:trader/variables/myvariables.dart';

class CreateItem extends StatefulWidget {
  final String ownerCat;
  final String ownerShop;
  const CreateItem({
    required this.ownerCat,
    required this.ownerShop,
    Key? key,
  }) : super(key: key);

  @override
  State<CreateItem> createState() => _CreateItemState();
}

class _CreateItemState extends State<CreateItem> {
  String _selectedState = "Available";
  String _selectedUnit = "Count";
  bool isopen1 = false;
  bool isopen2 = false;
  TextEditingController title = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController desc = TextEditingController();

  TextEditingController colors = TextEditingController();
  TextEditingController sizes = TextEditingController();

  List<String> colorslist = <String>[];
  List<String> sizeslist = <String>[];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(color41),
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "createprdct".tr,
                textDirection: textDirection,
                style: TextStyle(
                  fontSize: 26,
                  color: Color(color42),
                ),
              ),
            ),
          ),
          InputField(
            labelText: "title".tr,
            fillColor: Color(color31),
            width: size.width * 0.8,
            backgroundColor: Color(color42),
            keyboardType: TextInputType.text,
            controller: title,
          ),
          InputField(
            labelText: "price".tr,
            fillColor: Color(color31),
            width: size.width * 0.8,
            backgroundColor: Color(color42),
            keyboardType: TextInputType.number,
            controller: price,
          ),
          InputField(
            labelText: "description".tr,
            fillColor: Color(color31),
            width: size.width * 0.8,
            backgroundColor: Color(color42),
            keyboardType: TextInputType.text,
            controller: desc,
          ),
          const Divider(
            height: 20,
          ),
          ListTile(
            leading: Radio<String>(
              value: 'Available',
              groupValue: _selectedState,
              onChanged: (value) {
                setState(() {
                  _selectedState = value!;
                });
              },
            ),
            title: Text(
              'available'.tr,
              textDirection: textDirection,
            ),
          ),
          ListTile(
            leading: Radio<String>(
              value: 'Unavailable',
              groupValue: _selectedState,
              onChanged: (value) {
                setState(() {
                  _selectedState = value!;
                });
              },
            ),
            title: Text(
              'notavailable'.tr,
              textDirection: textDirection,
            ),
          ),
          const Divider(
            height: 20,
          ),
          ListTile(
            leading: Radio<String>(
              value: 'Weight',
              groupValue: _selectedUnit,
              onChanged: (value) {
                setState(() {
                  _selectedUnit = value!;
                });
              },
            ),
            title: Text(
              'weight'.tr,
              textDirection: textDirection,
            ),
          ),
          ListTile(
            leading: Radio<String>(
              value: 'Count',
              groupValue: _selectedUnit,
              onChanged: (value) {
                setState(() {
                  _selectedUnit = value!;
                });
              },
            ),
            title: Text(
              'count'.tr,
              textDirection: textDirection,
            ),
          ),
          const Divider(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 5,
              bottom: 5,
              right: 30,
              left: 30,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              textDirection: textDirection,
              children: [
                Text("hascolor".tr),
                Checkbox(
                  value: isopen1,
                  onChanged: (value) {
                    setState(() {
                      isopen1 = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          isopen1 == true
              ? valueListMaker(size.width, colorslist, colors, "colors".tr)
              : const Center(),
          const Divider(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 5,
              bottom: 5,
              right: 30,
              left: 30,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              textDirection: textDirection,
              children: [
                Text("hassize".tr),
                Checkbox(
                  value: isopen2,
                  onChanged: (value) {
                    setState(() {
                      isopen2 = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          isopen2 == true
              ? valueListMaker(size.width, sizeslist, sizes, "sizes".tr)
              : const Center(),
          const Divider(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 5,
              bottom: 5,
              right: 30,
              left: 30,
            ),
            child: myButton(
              size.width,
              "Create".tr,
              () async {
                EasyLoading.show(status: 'loading'.tr);
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                final response = await postrequest(
                  host,
                  "items",
                  jsonEncode({
                    'name': title.text,
                    'owner': widget.ownerCat,
                    'price': price.text,
                    'description': desc.text,
                    'unit': _selectedUnit,
                    'isavailable': _selectedState == 'Available' ? true : false,
                    'colors': colorslist,
                    'sizes': sizeslist,
                  }),
                  headers: {
                    'Content-Type': 'application/json',
                    'Authorization':
                        'Bearer ' + preferences.getString("token")!,
                  },
                );
                loader(response.statusCode);
                if (response.statusCode == 200) {
                  setState(() {});
                  Get.back();
                  setState(() {});
                }
              },
              Color(color42),
              Color(color42),
              Color(color41),
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
        ],
      ),
    );
  }

  Widget valueListMaker(double width, List<String> list,
      TextEditingController controller, String labelText) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 5,
        bottom: 20,
        right: 30,
        left: 30,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 8),
              blurRadius: 24,
              color: Colors.black.withAlpha(15),
            ),
          ],
          color: Colors.white,
        ),
        child: Column(
          children: [
            InputField(
              labelText: labelText,
              fillColor: Color(color31),
              width: width * 0.8,
              backgroundColor: Color(color42),
              keyboardType: TextInputType.text,
              controller: controller,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: myButton(
                width * 0.6,
                "Add".tr,
                () {
                  setState(
                    () {
                      list.add(controller.text);
                      controller.text = "";
                    },
                  );
                },
                Color(color42),
                Color(color42),
                Color(color41),
              ),
            ),
            list.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(20),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: list.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                              color: Color(color42),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 20,
                                left: 20,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(
                                        () {
                                          list.removeAt(index);
                                        },
                                      );
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Color(color41),
                                    ),
                                  ),
                                  Text(
                                    list[index],
                                    style: TextStyle(
                                      color: Color(color41),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
