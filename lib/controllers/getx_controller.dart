import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  void changeLanguage(var language, var country) {
    var locale = Locale(language, country);
    Get.updateLocale(locale);
  }
}
