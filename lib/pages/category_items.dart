import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trader/components/alerts.dart';
import 'package:trader/controllers/get_connect.dart';
import 'package:trader/models/item.dart';
import 'package:trader/pages/create_item.dart';
import 'package:trader/pages/edit_item.dart';
import 'package:trader/variables/myvariables.dart';

class CategoryItems extends StatefulWidget {
  final String token;
  final String categoryid;
  const CategoryItems({
    required this.categoryid,
    required this.token,
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryItems> createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {
  late int selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(color41),
      body: FutureBuilder<List<Item>>(
        future: getrequestItems(
          host,
          'items/byowner/' + widget.categoryid,
          headers: {
            'Authorization': 'Bearer ' + widget.token,
          },
        ),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return itemButton(snapshot.data![index], context);
                  },
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
            () => CreateItem(
              ownerCat: widget.categoryid,
              ownerShop: widget.token,
            ),
          );
        },
        backgroundColor: Color(color42),
        child: const Icon(Icons.add_box),
      ),
    );
  }

  Widget itemButton(Item item, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onLongPress: () async {
        await myDialogBox(
          context,
          "delete".tr,
          const Center(),
          <Widget>[
            TextButton(
              onPressed: () async {
                EasyLoading.show(status: 'loading'.tr);
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                final response = await deleteRequest(
                  host + 'items/' + item.id,
                  headers: {
                    'Content-Type': 'application/json',
                    'Authorization':
                        'Bearer ' + preferences.getString("token")!,
                  },
                );
                loader(response.statusCode);
                setState(() {});
                if (response.statusCode == 200) {
                  Get.back();
                  setState(() {});
                  setState(() {});
                }
              },
              child: Text("delete".tr),
            ),
            TextButton(
              onPressed: () async {
                Get.back();
              },
              child: Text("Cancel".tr),
            ),
          ],
        );
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          height: size.height * 0.25,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 8),
                blurRadius: 24,
                color: Colors.black.withAlpha(15),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                child: item.images.isNotEmpty
                    ? Image.network(
                        host + "images/items/" + item.images[0],
                        width: size.width * 0.4,
                        fit: BoxFit.cover,
                        height: size.height,
                      )
                    : Image.asset(
                        "assets/images/holder.png",
                        width: size.width * 0.4,
                        fit: BoxFit.cover,
                        height: size.height,
                      ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: Text(
                      item.name.toUpperCase(),
                      textDirection: textDirection,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 20,
                    ),
                    child: Text(
                      item.price + " " + "curncy".tr,
                      textDirection: textDirection,
                      style: const TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 10,
                    ),
                    child: Text(
                      item.isavailable == true
                          ? "available".tr
                          : "notavailable".tr,
                      textDirection: textDirection,
                      style: const TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      color: Color(0xff0E60F1),
                    ),
                    width: size.width * 0.45,
                    child: TextButton(
                      onPressed: () {
                        Get.to(
                          () => EditItem(
                            itemid: item.id,
                          ),
                        );
                      },
                      child: Text(
                        "details".tr,
                        textDirection: textDirection,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
