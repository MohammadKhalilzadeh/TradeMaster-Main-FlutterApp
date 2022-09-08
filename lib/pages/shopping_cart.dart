import 'package:flutter/material.dart';
import 'package:trader/components/alerts.dart';
import 'package:trader/models/mypick.dart';
import 'package:trader/pages/pay_for_cart.dart';
import 'package:trader/variables/myvariables.dart';
import 'package:get/get.dart';

class ShoppingCart extends StatefulWidget {
  final String shopname;
  final String shopid;
  final int delivery;
  const ShoppingCart({
    required this.shopid,
    required this.shopname,
    required this.delivery,
    Key? key,
  }) : super(key: key);

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(color41),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: myshoppingcart.length,
        itemBuilder: (context, index) {
          return picksButton(
            myshoppingcart[index],
            size,
            index,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          int totalp = 0;
          for (var p in myshoppingcart) {
            totalp += p.total;
          }

          Get.to(
            () => PayForCart(
              shopid: widget.shopid,
              shopname: widget.shopname,
              itemscost: totalp,
              delivery: widget.delivery,
              total: totalp + widget.delivery,
            ),
          );
        },
        backgroundColor: Color(color42),
        child: Text("finalize".tr),
      ),
    );
  }

  Widget picksButton(MyPick myPick, Size size, int index) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: size.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                myPick.name.toUpperCase(),
                style: TextStyle(
                  color: Color(color42),
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    myPick.price.toString() + " " + "curncy".tr,
                  ),
                  Text(
                    myPick.amount.toString() +
                        " : " +
                        (myPick.unit == "Count" ? "تعداد" : "وزن به گرم"),
                  ),
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  myPick.total.toString() + " : " + "مبلغ کل به ریال",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    myPick.color == "" ? "-" : myPick.color,
                  ),
                  Text(
                    myPick.size == "" ? "-" : myPick.size,
                  ),
                ],
              ),
            ),
            Container(
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                color: Color(color43),
              ),
              child: TextButton(
                onPressed: () {
                  myDialogBox(
                    context,
                    "delete".tr,
                    Text("delete?".tr),
                    <Widget>[
                      TextButton(
                        onPressed: () {
                          setState(() {
                            myshoppingcart.removeAt(index);
                          });
                          if (myshoppingcart.isEmpty) {
                            Get.back();
                          }
                          Get.back();
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
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
