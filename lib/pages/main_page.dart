import 'package:flutter/material.dart';
import 'package:trader/components/menu.dart';
import 'package:trader/pages/around_you.dart';
import 'package:trader/pages/your_shops.dart';
import 'package:trader/variables/myvariables.dart';
import 'package:get/get.dart';

class MainScreen extends StatefulWidget {
  final String userid;
  final String phone;
  const MainScreen({
    required this.userid,
    required this.phone,
    Key? key,
  }) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late String id;

  int _selectedIndex = 0;
  late final List<Widget> _widgetOptions = <Widget>[
    const AroundYou(),
    YourShops(userid: id),
  ];

  @override
  void initState() {
    super.initState();
    id = widget.userid;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(color42),
          centerTitle: true,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          title: Text(
            "trademaster".tr,
            style: TextStyle(
              color: Colors.white,
              fontFamily: fontfamily,
            ),
          ),
        ),
        endDrawer: MyMenu(
          width: width,
          phone: widget.phone,
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(color42),
          unselectedItemColor: Colors.white,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.shopping_bag, color: Colors.white),
              label: "letsshop".tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.account_balance, color: Colors.white),
              label: 'yourshops'.tr,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
