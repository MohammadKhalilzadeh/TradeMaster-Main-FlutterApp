import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trader/components/alerts.dart';
import 'package:trader/components/profile_widgets.dart';
import 'package:trader/variables/myvariables.dart';
import 'package:get/get.dart';
import '../controllers/get_connect.dart';

class NewShopForm extends StatefulWidget {
  final LatLng latLng;
  const NewShopForm({
    required this.latLng,
    Key? key,
  }) : super(key: key);

  @override
  State<NewShopForm> createState() {
    // ignore: no_logic_in_create_state
    return _NewShopFormState(latLng);
  }
}

class _NewShopFormState extends State<NewShopForm> {
  final LatLng _latLng;
  TextEditingController title = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController sheba = TextEditingController();
  TextEditingController delivery = TextEditingController();
  TextEditingController desc = TextEditingController();

  _NewShopFormState(this._latLng);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(color42),
      body: ListView(
        children: [
          SizedBox(
            height: width * 0.2,
          ),
          Container(
            padding: EdgeInsets.all(width * 0.05),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: Color(color41),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(60),
                  spreadRadius: 3,
                  blurRadius: 3, // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(height: width * 0.1),
                myTextField(width, "shoptitle".tr, title, TextInputType.text),
                SizedBox(height: width * 0.075),
                myTextField(width, "phone".tr, phone, TextInputType.phone),
                SizedBox(height: width * 0.075),
                myTextField(
                    width, "email".tr, email, TextInputType.emailAddress),
                SizedBox(height: width * 0.075),
                myTextField(
                    width, "address".tr, address, TextInputType.streetAddress,
                    maxline: 5),
                SizedBox(height: width * 0.075),
                myTextField(width, "sheba".tr, sheba, TextInputType.text),
                SizedBox(height: width * 0.075),
                myTextField(
                    width, "delivery".tr, delivery, TextInputType.number),
                SizedBox(height: width * 0.075),
                myTextField(
                  width,
                  "description".tr,
                  desc,
                  TextInputType.text,
                  maxline: 5,
                ),
                SizedBox(height: width * 0.1),
                myButton(
                  width * 0.5,
                  "Request".tr,
                  () async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();

                    if (title.text == "" ||
                        phone.text == "" ||
                        email.text == "" ||
                        address.text == "" ||
                        sheba.text == "" ||
                        desc.text == "") {
                      showMyDialog(
                        context,
                        "err".tr,
                        "noempty".tr,
                      );
                    } else {
                      EasyLoading.show(status: 'loading'.tr);
                      final response = await postrequest(
                        host,
                        "business",
                        jsonEncode(
                          {
                            'title': title.text,
                            'phone': phone.text,
                            'email': email.text,
                            'address': address.text,
                            'sheba': sheba.text,
                            'delivery':
                                delivery.text.isEmpty ? 0 : delivery.text,
                            'description': desc.text,
                            'latitude': _latLng.latitude,
                            'longitude': _latLng.longitude,
                            'owner': preferences.getString('userid')!
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
                        Get.back();
                      }
                    }
                  },
                  Color(color42),
                  Color(color42),
                  Color(color41),
                ),
                SizedBox(height: width * 0.1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
