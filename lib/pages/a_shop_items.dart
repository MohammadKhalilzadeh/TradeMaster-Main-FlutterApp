import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trader/components/alerts.dart';
import 'package:trader/controllers/get_connect.dart';
import 'package:trader/models/item.dart';
import 'package:trader/pages/add_item.dart';
import 'package:trader/pages/shopping_cart.dart';
import 'package:trader/variables/myvariables.dart';

class AShopItems extends StatefulWidget {
  final String shopname;
  final String shopid;
  final String token;
  final String categoryid;
  final int delivery;
  const AShopItems({
    required this.categoryid,
    required this.token,
    required this.shopid,
    required this.shopname,
    required this.delivery,
    Key? key,
  }) : super(key: key);

  @override
  State<AShopItems> createState() => _AShopItemsState();
}

class _AShopItemsState extends State<AShopItems> {
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
          if (myshoppingcart.isNotEmpty) {
            Get.to(
              () => ShoppingCart(
                shopid: widget.shopid,
                shopname: widget.shopname,
                delivery: widget.delivery,
              ),
            );
          } else {
            showMyDialog(
              context,
              "err".tr,
              "سبد خرید خالی است",
            );
          }
        },
        backgroundColor: Color(color42),
        child: const Icon(
          Icons.shopping_cart,
        ),
      ),
    );
  }

  Widget itemButton(Item item, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
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
                      fit: BoxFit.cover,
                      width: size.width * 0.4,
                      height: size.height,
                    )
                  : Image.asset(
                      "assets/images/holder.png",
                      fit: BoxFit.cover,
                      width: size.width * 0.4,
                      height: size.height,
                    ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textDirection: textDirection,
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
                    bottom: 10,
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
                    item.isavailable == true ? "available".tr : "available".tr,
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
                  width: size.width * 0.4,
                  child: TextButton(
                    onPressed: () {
                      Get.to(
                        () => AddItem(
                          itemid: item.id,
                          firstColor:
                              item.colors.isNotEmpty ? item.colors[0] : "-",
                          firstSize:
                              item.sizes.isNotEmpty ? item.sizes[0] : "-",
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
    );
  }
}
