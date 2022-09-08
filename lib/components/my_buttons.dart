// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:trader/variables/myvariables.dart';

class MyButton extends StatelessWidget {
  final Color backgroundColor;
  final Color? color;
  final double width;
  final String name;
  final VoidCallback? onPress;
  const MyButton({
    required this.backgroundColor,
    required this.width,
    this.color,
    required this.name,
    this.onPress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 30,
        right: 30,
        top: 10,
        bottom: 10,
      ),
      child: Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: backgroundColor,
        ),
        child: TextButton(
          onPressed: onPress,
          child: Text(
            name,
            textDirection: textDirection,
            style: TextStyle(
              color: color,
              fontFamily: fontfamily,
            ),
          ),
        ),
      ),
    );
  }
}
