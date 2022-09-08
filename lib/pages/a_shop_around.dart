import 'package:flutter/material.dart';
import 'package:trader/controllers/get_connect.dart';
import 'package:trader/models/business.dart';
import 'package:trader/pages/a_shop_categories.dart';
import 'package:trader/variables/myvariables.dart';

class AShopAround extends StatefulWidget {
  final String shopname;
  final String id;
  final String token;
  final int delivery;
  const AShopAround({
    required this.id,
    required this.token,
    required this.shopname,
    required this.delivery,
    Key? key,
  }) : super(key: key);

  @override
  State<AShopAround> createState() => _AShopAroundState();
}

class _AShopAroundState extends State<AShopAround> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Color(color41),
        body: FutureBuilder<Business>(
          future: getBusiness(host, "business/" + widget.id),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: width * 0.2,
                      ),
                      Center(
                        child: Text(
                          snapshot.data!.title.toUpperCase(),
                          style: TextStyle(
                            color: Color(color42),
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      AShopCategories(
                        ownerid: widget.id,
                        token: widget.token,
                        shopname: widget.shopname,
                        delivery: widget.delivery,
                      ),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}
