import 'package:flutter/material.dart';
import 'package:trader/variables/myvariables.dart';
import 'package:get/get.dart';

class MenuBtn extends StatelessWidget {
  final String name;
  final IconData? iconData;
  final VoidCallback ontap;

  const MenuBtn({
    required this.name,
    this.iconData,
    required this.ontap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          decoration: BoxDecoration(
            color: Color(color42),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(60),
                spreadRadius: 1,
                blurRadius: 2, // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  iconData,
                  color: Color(color41),
                  size: 25,
                ),
                Text(
                  name.tr,
                  style: TextStyle(
                    color: Color(color41),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
