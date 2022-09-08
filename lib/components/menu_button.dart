import 'package:flutter/material.dart';
import 'package:trader/variables/myvariables.dart';
import 'package:get/get.dart';

class MenuButton extends StatelessWidget {
  final double vertical;
  final double horizon;
  final String name;
  final IconData? icon;
  final VoidCallback ontap;
  const MenuButton({
    required this.vertical,
    required this.horizon,
    required this.name,
    this.icon,
    required this.ontap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: EdgeInsets.only(
          top: vertical,
          bottom: vertical,
          left: horizon,
          right: horizon,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Color(color41),
              size: 25,
            ),
            Text(
              name.tr,
              style: TextStyle(
                color: Color(color41),
                fontSize: 20,
                fontFamily: fontfamily,
              ),
            )
          ],
        ),
      ),
    );
  }
}
