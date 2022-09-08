import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:trader/variables/myvariables.dart';

Future<void> myDialogBox(
  BuildContext context,
  String title,
  Widget content,
  List<Widget>? actions,
) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          textDirection: textDirection,
        ),
        content: SingleChildScrollView(
          child: content,
        ),
        actions: actions,
      );
    },
  );
}

Future<void> showMyDialog(
    BuildContext context, String title, String message) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          textDirection: textDirection,
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                message,
                textDirection: textDirection,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('approve'.tr),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

loader(int statusCode) async {
  if (statusCode == 200) {
    EasyLoading.showSuccess('success'.tr);
  } else if (statusCode == 201) {
    EasyLoading.showSuccess('success'.tr);
  } else if (statusCode == 202) {
    EasyLoading.showSuccess('success'.tr);
  } else if (statusCode == 401) {
    EasyLoading.showSuccess('wrngpass'.tr);
  } else if (statusCode == 404) {
    EasyLoading.showSuccess('notausr'.tr);
  } else if (statusCode == 409) {
    EasyLoading.showSuccess('rpetdusr'.tr);
  } else if (statusCode == 500) {
    EasyLoading.showSuccess('srvrerr'.tr);
  } else {
    EasyLoading.showError('srvrerr'.tr);
  }
  EasyLoading.dismiss();
}
