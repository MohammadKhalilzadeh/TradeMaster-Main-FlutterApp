import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trader/components/alerts.dart';
import 'package:trader/controllers/get_connect.dart';
import 'package:trader/models/category.dart';
import 'package:trader/pages/category_items.dart';
import 'package:trader/pages/shop_setting.dart';
import 'package:trader/pages/your_shop_orders.dart';
import 'package:trader/variables/myvariables.dart';

class MyCategoryList extends StatefulWidget {
  final String ownerid;
  final String token;
  const MyCategoryList({
    required this.ownerid,
    required this.token,
    Key? key,
  }) : super(key: key);

  @override
  State<MyCategoryList> createState() => _MyCategoryListState();
}

class _MyCategoryListState extends State<MyCategoryList> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<Category>>(
        future: getCategories(
          host,
          "categories/" + widget.ownerid,
          headers: {
            'Authorization': 'Bearer ' + widget.token,
          },
        ),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? DefaultTabController(
                  length: snapshot.data!.length,
                  child: tabsMaker(snapshot.data!, context, widget.token),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }

  Widget tabsMaker(List<Category> list, BuildContext context, String token) {
    List<Tab> tabslist = <Tab>[];
    List<CategoryItems> containerslist = <CategoryItems>[];

    for (var i = 0; i < list.length; i++) {
      tabslist.add(
        Tab(
          height: 60,
          child: GestureDetector(
            onLongPress: () {
              myDialogBox(
                context,
                "warning".tr,
                Text(
                  "delete?".tr,
                  textDirection: textDirection,
                ),
                <Widget>[
                  TextButton(
                    onPressed: () async {
                      EasyLoading.show(status: 'loading'.tr);
                      final response = await deleteRequest(
                        host + "categories/" + list[i].id,
                        headers: {
                          'Authorization': 'Bearer ' + widget.token,
                        },
                      );

                      loader(response.statusCode);
                      if (response.statusCode == 200) {
                        Get.back();
                      }

                      setState(() {});
                    },
                    child: Text("delete".tr),
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
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 8),
                    blurRadius: 24,
                    color: Colors.black.withAlpha(15),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  list[i].title,
                  style: TextStyle(
                    color: Color(color42),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      containerslist.add(
        // ignore: avoid_unnecessary_containers
        CategoryItems(
          categoryid: list[i].id,
          token: widget.token,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(color41),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Categories'.tr,
          style: TextStyle(
            fontSize: 16.0,
            color: Color(color42),
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              myDialogBox(
                context,
                "addcat".tr,
                TextField(
                  controller: controller,
                  textDirection: textDirection,
                  decoration: InputDecoration(
                    hintText: "addnew".tr,
                  ),
                ),
                <Widget>[
                  TextButton(
                    onPressed: () async {
                      EasyLoading.show(status: 'loading'.tr);
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      final response = await postrequest(
                        host,
                        "categories".tr,
                        jsonEncode(
                          {
                            'title': controller.text,
                            'owner': widget.ownerid,
                          },
                        ),
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

                      setState(() {});
                      controller.text = "";
                      setState(() {});
                    },
                    child: Text("Add".tr),
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
              Icons.add,
              color: Color(color42),
            ),
          ),
          IconButton(
            onPressed: () {
              Get.to(
                () => ShopSetting(shopid: widget.ownerid),
              );
            },
            icon: Icon(
              Icons.settings,
              color: Color(color42),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              onPressed: () {
                Get.to(
                  () => MyShopOrders(shopid: widget.ownerid),
                );
              },
              icon: Icon(
                Icons.list_alt,
                color: Color(color42),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          child: TabBar(
            isScrollable: true,
            indicatorColor: Color(color41),
            tabs: tabslist,
          ),
          preferredSize: const Size.fromHeight(60),
        ),
      ),
      body: TabBarView(
        children: containerslist,
      ),
    );
  }
}
