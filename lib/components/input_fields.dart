// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:trader/variables/myvariables.dart';

class InputField extends StatelessWidget {
  final String? labelText;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final String? errorText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool autoFocus;
  final bool obscureText;
  final Color? cursorColor;
  final Color? fillColor;
  final Color? focusColor;
  final Color? hoverColor;
  final TextEditingController? controller;
  final Color backgroundColor;
  final Color? color;
  final double width;
  const InputField(
      {this.labelText,
      required this.backgroundColor,
      this.color,
      this.onChanged,
      this.onSubmitted,
      required this.width,
      this.errorText,
      this.keyboardType,
      this.textInputAction,
      this.autoFocus = false,
      this.obscureText = false,
      this.cursorColor,
      this.fillColor,
      this.focusColor,
      this.hoverColor,
      this.controller,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 30,
        right: 30,
      ),
      child: Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: backgroundColor,
          ),
          color: Color(color41),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: TextField(
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            keyboardType: keyboardType,
            textAlign: TextAlign.center,
            textDirection: textDirection,
            obscureText: obscureText,
            cursorColor: cursorColor,
            controller: controller,
            textInputAction: textInputAction,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintTextDirection: textDirection,
              labelStyle: TextStyle(
                color: backgroundColor,
                fontFamily: fontfamily,
              ),
              hintStyle: TextStyle(
                color: backgroundColor,
                fontFamily: fontfamily,
              ),
              hintText: labelText,
              focusColor: focusColor,
              fillColor: fillColor,
            ),
          ),
        ),
      ),
    );
  }
}
