// it's okay
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trader/components/alerts.dart';
import 'package:trader/components/profile_widgets.dart';
import 'package:trader/controllers/get_connect.dart';
import 'package:trader/models/user.dart';
import 'package:trader/variables/myvariables.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  final String userid;
  const Profile({
    required this.userid,
    Key? key,
  }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isOpen = false;
  bool isOpen2 = false;
  bool isOpen3 = false;

  TextEditingController sheba = TextEditingController();
  TextEditingController card = TextEditingController();

  TextEditingController cityC = TextEditingController();
  TextEditingController provinceC = TextEditingController();
  TextEditingController postalcodeC = TextEditingController();
  TextEditingController addressC = TextEditingController();

  File? file;

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  Future galleryImagePicker() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imageTemp = File(image.path);

    setState(() {
      file = imageTemp;
    });
    Get.back();
  }

  Future cameraImagePicker() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;

    final imageTemp = File(image.path);

    setState(() {
      file = imageTemp;
    });
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(color41),
      body: FutureBuilder<User>(
          future: getUser(host, "users/" + widget.userid),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ListView(
                    children: [
                      SizedBox(height: width * 0.2),
                      Container(
                        padding: EdgeInsets.all(width * 0.05),
                        decoration: BoxDecoration(
                          color: Color(color42),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(60),
                              spreadRadius: 1,
                              blurRadius: 1, // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(width * 0.1),
                              child: Text(
                                snapshot.data!.firstname +
                                    " " +
                                    snapshot.data!.lastname,
                                style: TextStyle(
                                  color: Color(color41),
                                  fontFamily: 'Lalezar',
                                  fontSize: 22,
                                ),
                              ),
                            ),
                            userGeneralInfo(
                              width,
                              context,
                              snapshot.data!.phone.toString(),
                              snapshot.data!.email,
                              snapshot.data!.password,
                            ),
                            SizedBox(
                              height: width * 0.1,
                            ),
                            financialInfo(
                              width,
                              snapshot.data!.sheba,
                              snapshot.data!.cardnumber,
                            ),
                            SizedBox(
                              height: width * 0.1,
                            ),
                            addressInfo(
                              width,
                              snapshot.data!.city,
                              snapshot.data!.province,
                              snapshot.data!.postalcode,
                              snapshot.data!.address,
                            ),
                            SizedBox(
                              height: width * 0.1,
                            ),
                            snapshot.data!.imgs.length == 2 &&
                                    snapshot.data!.verified == true
                                ? const Center(
                                    child: Icon(
                                      Icons.check,
                                      size: 50,
                                      color: Colors.green,
                                    ),
                                  )
                                : yourImages(
                                    width,
                                    "identify".tr,
                                    snapshot.data!.imgs.length,
                                  ),
                            SizedBox(
                              height: width * 0.3,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          }),
    );
  }

  Widget yourImages(double width, String name, int length) {
    IconData data = isOpen3 == false
        ? Icons.navigate_next_sharp
        : Icons.arrow_drop_down_outlined;
    return Container(
      width: width * 0.9,
      padding: EdgeInsets.all(width * 0.05),
      decoration: BoxDecoration(
        color: Color(color41),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(60),
            spreadRadius: 3,
            blurRadius: 3, // changes position of shadow
          ),
        ],
      ),
      child: length < 2
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                length == 0
                    ? const Center(
                        child: Text("لطفا عکس احرازهویت خود را آپلود کنید"),
                      )
                    : const Center(),
                length == 1
                    ? const Center(
                        child: Text("لطفا عکس کارت ملی خود را آپلود کنید"),
                      )
                    : const Center(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  textDirection: textDirection,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        color: Color(color42),
                        fontFamily: 'Lalezar',
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isOpen3 = !isOpen3;
                        });
                      },
                      icon: Icon(
                        data,
                        color: Color(color42),
                      ),
                    ),
                  ],
                ),
                isOpen3 == true
                    ? Container(
                        height: width * 0.3,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(color42),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: file != null
                              ? Image.file(
                                  file!,
                                  fit: BoxFit.cover,
                                )
                              : IconButton(
                                  onPressed: () async {
                                    myDialogBox(
                                      context,
                                      "PickImage".tr,
                                      Text("uploaddocs".tr),
                                      <Widget>[
                                        TextButton(
                                          onPressed: galleryImagePicker,
                                          child: Text("Gallery".tr),
                                        ),
                                        TextButton(
                                          onPressed: cameraImagePicker,
                                          child: Text("Camera".tr),
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
                                    Icons.image,
                                    color: Color(color42),
                                  ),
                                ),
                        ),
                      )
                    : const Center(),
                isOpen3 == true
                    ? Padding(
                        padding: const EdgeInsets.all(10),
                        child: myButton(
                          width,
                          "Upload".tr,
                          () async {
                            EasyLoading.show(status: 'loading'.tr);
                            final response = await uploadImage(
                              file!,
                              host,
                              "users/images/pics/" + widget.userid,
                              "image",
                            );

                            if (response.statusCode == 200) {
                              EasyLoading.showSuccess('success'.tr);
                              Get.back();
                            } else {
                              EasyLoading.showError('failed'.tr);
                            }
                            EasyLoading.dismiss();
                          },
                          Color(color41),
                          Color(color42),
                          Color(color42),
                        ),
                      )
                    : const Center(),
              ],
            )
          : const Center(
              child: Text("در انتظار بررسی برای تایید احرازهویت"),
            ),
    );
  }

  Widget addressInfo(
    double width,
    String city,
    String province,
    int postalcode,
    String address,
  ) {
    IconData data = isOpen2 == false
        ? Icons.navigate_next_sharp
        : Icons.arrow_drop_down_outlined;
    return Container(
      width: width * 0.9,
      padding: EdgeInsets.all(width * 0.05),
      decoration: BoxDecoration(
        color: Color(color41),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(60),
            spreadRadius: 3,
            blurRadius: 3, // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textDirection: textDirection,
            children: [
              Text(
                "Your Address".tr,
                style: TextStyle(
                  color: Color(color42),
                  fontFamily: 'Lalezar',
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    isOpen2 = !isOpen2;
                  });
                },
                icon: Icon(
                  data,
                  color: Color(color42),
                ),
              ),
            ],
          ),
          isOpen2 == true
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    addressField(
                      width * 0.4,
                      cityC,
                      'City'.tr,
                      city,
                    ),
                    addressField(
                      width * 0.4,
                      provinceC,
                      'Provice'.tr,
                      province,
                    ),
                  ],
                )
              : const Center(),
          isOpen2 == true
              ? SizedBox(
                  height: width * 0.05,
                )
              : const Center(),
          isOpen2 == true
              ? addressField(
                  width,
                  postalcodeC,
                  'Postal Code'.tr,
                  postalcode,
                  keyboardType: TextInputType.number,
                )
              : const Center(),
          isOpen2 == true
              ? SizedBox(
                  height: width * 0.05,
                )
              : const Center(),
          isOpen2 == true
              ? addressField(
                  width,
                  addressC,
                  'address'.tr,
                  address,
                  lines: 5,
                )
              : const Center(),
          isOpen2 == true
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: city == "-" ||
                          province == '-' ||
                          postalcode == 0 ||
                          address == '-'
                      ? myButton(
                          width * 0.6,
                          "Send".tr,
                          () async {
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            final response = await patchRequest(
                              host,
                              "users/ident/" + preferences.getString("userid")!,
                              jsonEncode(
                                {
                                  'city': city == '-'
                                      ? (cityC.text.isEmpty ? '-' : cityC.text)
                                      : city,
                                  'province': province == '-'
                                      ? (provinceC.text.isEmpty
                                          ? '-'
                                          : provinceC.text)
                                      : province,
                                  'postalcode': postalcode == 0
                                      ? int.parse(postalcodeC.text.isEmpty
                                          ? "0"
                                          : postalcodeC.text)
                                      : postalcode,
                                  'address': address == '-'
                                      ? (addressC.text.isEmpty
                                          ? "-"
                                          : addressC.text)
                                      : address,
                                },
                              ),
                              context,
                              headers: {
                                'Content-Type': 'application/json',
                                'Authorization':
                                    'Bearer ' + preferences.getString("token")!,
                              },
                            );

                            loader(response.statusCode);
                            if (response.statusCode == 200) {
                              setState(() {});
                            }
                          },
                          Color(color41),
                          Color(color42),
                          Color(color42),
                        )
                      : const Center(),
                )
              : const Center(),
        ],
      ),
    );
  }

  Widget financialInfo(double width, String shebaNo, int credit) {
    IconData data = isOpen == false
        ? Icons.navigate_next_sharp
        : Icons.arrow_drop_down_outlined;
    return Container(
      width: width * 0.9,
      padding: EdgeInsets.all(width * 0.05),
      decoration: BoxDecoration(
        color: Color(color41),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(60),
            spreadRadius: 3,
            blurRadius: 3, // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textDirection: textDirection,
            children: [
              Text(
                "financeinfo".tr,
                style: TextStyle(
                  color: Color(color42),
                  fontFamily: 'Lalezar',
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    isOpen = !isOpen;
                  });
                },
                icon: Icon(
                  data,
                  color: Color(color42),
                ),
              ),
            ],
          ),
          isOpen == true ? shebaField(width, sheba, shebaNo) : const Center(),
          isOpen == true
              ? SizedBox(
                  height: width * 0.05,
                )
              : const Center(),
          isOpen == true ? cardField(width, card, credit) : const Center(),
          isOpen == true
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: shebaNo == '-' || credit == 0
                      ? myButton(
                          width * 0.6,
                          "Send".tr,
                          () async {
                            EasyLoading.show(status: 'loading'.tr);
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            final response = await patchRequest(
                              host,
                              "users/ident/" + preferences.getString("userid")!,
                              jsonEncode(
                                {
                                  'sheba': shebaNo == '-'
                                      ? (sheba.text.isEmpty ? "-" : sheba.text)
                                      : shebaNo,
                                  'cardnumber': credit == 0
                                      ? (card.text.isEmpty ? 0 : card.text)
                                      : credit,
                                },
                              ),
                              context,
                              headers: {
                                'Content-Type': 'application/json',
                                'Authorization':
                                    'Bearer ' + preferences.getString("token")!,
                              },
                            );

                            loader(response.statusCode);

                            if (response.statusCode == 200) {
                              setState(() {});
                            }
                          },
                          Color(color41),
                          Color(color42),
                          Color(color42),
                        )
                      : const Center(),
                )
              : const Center(),
        ],
      ),
    );
  }
}
