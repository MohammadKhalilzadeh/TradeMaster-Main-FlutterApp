import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trader/components/alerts.dart';
import 'package:trader/components/profile_widgets.dart';
import 'package:trader/controllers/get_connect.dart';
import 'package:trader/variables/myvariables.dart';
import 'package:get/get.dart';

class UploadImage extends StatefulWidget {
  final String dest;
  const UploadImage({
    required this.dest,
    Key? key,
  }) : super(key: key);

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? file;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(color41),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: size.width * 0.9,
              height: size.height * 0.3,
              decoration: BoxDecoration(
                color: Color(color42),
                borderRadius: BorderRadius.circular(20),
              ),
              child: file != null
                  ? Image.file(
                      file!,
                      fit: BoxFit.cover,
                    )
                  : Center(
                      child: Text(
                        "noimgchoosed".tr,
                        style: TextStyle(
                          color: Color(color41),
                        ),
                      ),
                    ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              myButton(
                size.width * 0.3,
                "Upload".tr,
                () async {
                  EasyLoading.show(status: 'Loading'.tr);
                  final response = await uploadImage(
                    file!,
                    host,
                    widget.dest,
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
              myButton(
                size.width * 0.3,
                "PickImage".tr,
                () async {
                  myDialogBox(
                    context,
                    "PickImage2".tr,
                    const Center(),
                    <Widget>[
                      TextButton(
                        onPressed: cameraImagePicker,
                        child: Text("Camera".tr),
                      ),
                      TextButton(
                        onPressed: galleryImagePicker,
                        child: Text("Gallery".tr),
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
                Color(color41),
                Color(color42),
                Color(color42),
              ),
            ],
          ),
        ],
      ),
    );
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
}
