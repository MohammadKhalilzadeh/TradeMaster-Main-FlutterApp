import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trader/app_translation.dart';
import 'package:trader/pages/main_page.dart';
import 'package:trader/pages/wp.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  final String userid = preferences.getString("userid") ?? "";
  final String phone = preferences.getString("phone") ?? "";
  runApp(
    MyApp(
      phone: phone,
      userid: userid,
    ),
  );
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  final String userid;
  final String phone;
  const MyApp({
    required this.phone,
    required this.userid,
    Key? key,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TradeMasterShop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Lalezar',
        primaryColor: Colors.amber,
        textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
      ),
      home: (userid != "" || phone != "")
          ? MainScreen(userid: userid, phone: phone)
          : const WelcomePage(),
      locale: const Locale('fn', 'Farsi'),
      fallbackLocale: const Locale('fn', 'Farsi'),
      translations: AppTranslation(),
      builder: EasyLoading.init(),
    );
  }
}
