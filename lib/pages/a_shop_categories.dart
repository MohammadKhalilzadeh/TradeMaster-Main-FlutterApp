import 'package:flutter/material.dart';
import 'package:trader/components/alerts.dart';
import 'package:trader/controllers/get_connect.dart';
import 'package:trader/models/category.dart';
import 'package:trader/pages/a_shop_items.dart';
import 'package:trader/variables/myvariables.dart';
import 'package:get/get.dart';

class AShopCategories extends StatefulWidget {
  final String shopname;
  final String ownerid;
  final String token;
  final int delivery;
  const AShopCategories({
    required this.ownerid,
    required this.token,
    required this.shopname,
    required this.delivery,
    Key? key,
  }) : super(key: key);

  @override
  State<AShopCategories> createState() => _AShopCategoriesState();
}

class _AShopCategoriesState extends State<AShopCategories> {
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
    List<AShopItems> containerslist = <AShopItems>[];

    for (var i = 0; i < list.length; i++) {
      tabslist.add(
        Tab(
          height: 60,
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
      );

      containerslist.add(
        // ignore: avoid_unnecessary_containers
        AShopItems(
          categoryid: list[i].id,
          token: widget.token,
          shopid: widget.ownerid,
          shopname: widget.shopname,
          delivery: widget.delivery,
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              onPressed: () {
                myDialogBox(
                  context,
                  "err".tr,
                  Text(
                    "در صورت خروج از این فروشگاه سبد خرید شما حذف میشود",
                    textDirection: textDirection,
                  ),
                  <Widget>[
                    TextButton(
                      onPressed: () async {
                        myshoppingcart.clear();
                        Get.back();
                        Get.back();
                        setState(() {});
                      },
                      child: Text(
                        "nxt".tr,
                        textDirection: textDirection,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();
                        setState(() {});
                      },
                      child: Text(
                        "Cancel".tr,
                        textDirection: textDirection,
                      ),
                    ),
                  ],
                );
              },
              icon: Icon(
                Icons.login_outlined,
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
