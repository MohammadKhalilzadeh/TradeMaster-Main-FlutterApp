import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:trader/components/input_fields.dart';
import 'package:trader/components/profile_widgets.dart';
import 'package:trader/controllers/get_connect.dart';
import 'package:trader/models/item.dart';
import 'package:trader/models/mypick.dart';
import 'package:trader/variables/myvariables.dart';
import 'package:get/get.dart';

class AddItem extends StatefulWidget {
  final String itemid;
  final String firstColor;
  final String firstSize;
  const AddItem({
    required this.itemid,
    required this.firstColor,
    required this.firstSize,
    Key? key,
  }) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  TextEditingController price = TextEditingController();
  TextEditingController desc = TextEditingController();

  TextEditingController manual = TextEditingController();
  late String selectedColor = widget.firstColor;
  late String selectedSize = widget.firstSize;
  int number = 0;
  int total = 0;

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
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          textDirection: textDirection,
                          children: [
                            Text(snapshot.data!.price),
                            Text("price".tr),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      height: 10,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "description".tr,
                          textDirection: textDirection,
                          style: TextStyle(
                            color: Color(color42),
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        snapshot.data!.description,
                        textDirection: textDirection,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Color(color42).withOpacity(0.6),
                          fontWeight: FontWeight.w100,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    snapshot.data!.colors.isEmpty
                        ? const Center()
                        : const Divider(
                            height: 10,
                          ),
                    snapshot.data!.colors.isEmpty
                        ? const Center()
                        : Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                "choosecolor".tr,
                                style: TextStyle(
                                  color: Color(color42),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                    snapshot.data!.colors.isEmpty
                        ? const Center()
                        : itemChooser1(
                            selectedColor,
                            snapshot.data!.colors,
                            size,
                          ),
                    snapshot.data!.sizes.isEmpty
                        ? const Center()
                        : const Divider(
                            height: 10,
                          ),
                    snapshot.data!.sizes.isEmpty
                        ? const Center()
                        : Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                "choosesize".tr,
                                style: TextStyle(
                                  color: Color(color42),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                    snapshot.data!.sizes.isEmpty
                        ? const Center()
                        : itemChooser2(
                            selectedSize,
                            snapshot.data!.sizes,
                            size,
                          ),
                    const Divider(
                      height: 10,
                    ),
                    calculator(
                      snapshot.data!.unit,
                      size,
                      int.parse(snapshot.data!.price),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: SizedBox(
                        width: size.width * 0.6,
                        child: myButton(
                          size.width * 0.6,
                          "totalprice".tr +
                              " : " +
                              total.toString() +
                              " " +
                              "(افزودن به سبد)",
                          () async {
                            EasyLoading.showSuccess('success'.tr);
                            MyPick myPick = MyPick(
                              id: snapshot.data!.id,
                              name: snapshot.data!.name,
                              owner: snapshot.data!.owner,
                              price: int.parse(snapshot.data!.price),
                              unit: snapshot.data!.unit,
                              color: selectedColor,
                              size: selectedSize,
                              amount: snapshot.data!.unit == "Count"
                                  ? number
                                  : int.parse(manual.text),
                              total: total,
                            );

                            myshoppingcart.add(myPick);
                            EasyLoading.dismiss();
                            Get.back();
                          },
                          Color(color41),
                          Color(color42),
                          Color(color42),
                        ),
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }

  Widget calculator(String unit, Size size, int price) {
    return unit == "Count"
        ? Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: size.width * 0.6,
                decoration: BoxDecoration(
                  color: Color(color42),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (number > 0) {
                          setState(() {
                            number -= 1;
                            total = number * price;
                          });
                        }
                      },
                      icon: Icon(
                        Icons.remove,
                        color: Color(color41),
                      ),
                    ),
                    Text(
                      number.toString(),
                      style: TextStyle(
                        color: Color(color41),
                        fontSize: 30,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          number += 1;
                          total = number * price;
                        });
                      },
                      icon: Icon(
                        Icons.add,
                        color: Color(color41),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: size.height * 0.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    InputField(
                      backgroundColor: Color(color42),
                      width: size.width * 0.4,
                      fillColor: Color(color42),
                      keyboardType: TextInputType.number,
                      controller: manual,
                    ),
                    myButton(
                      size.width * 0.3,
                      "Calculate".tr,
                      () {
                        setState(() {
                          double q = (int.parse(manual.text) * price) / 1000;
                          total = q.toInt();
                        });
                      },
                      Color(color41),
                      Color(color42),
                      Color(color42),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Widget itemChooser1(String dropdownValue, List<dynamic> list, Size size) {
    final List<String> strs = list.map((e) => e.toString()).toList();
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Container(
          width: size.width * 0.6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color(color41),
            border: Border.all(
              color: Color(color42),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: dropdownValue,
              icon: Icon(
                Icons.arrow_downward,
                color: Color(color41),
              ),
              elevation: 16,
              style: TextStyle(
                color: Color(color42),
              ),
              underline: Container(
                height: 2,
                color: Color(color41),
              ),
              onChanged: (String? newValue) {
                setState(() {
                  selectedColor = newValue!;
                });
              },
              items: strs.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
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

  Widget itemChooser2(String dropdownValue, List<dynamic> list, Size size) {
    final List<String> strs = list.map((e) => e.toString()).toList();
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Container(
          width: size.width * 0.6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color(color41),
            border: Border.all(
              color: Color(color42),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: dropdownValue,
              icon: Icon(
                Icons.arrow_downward,
                color: Color(color41),
              ),
              elevation: 16,
              style: TextStyle(
                color: Color(color42),
              ),
              underline: Container(
                height: 2,
                color: Color(color41),
              ),
              onChanged: (String? newValue) {
                setState(() {
                  selectedSize = newValue!;
                });
              },
              items: strs.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
