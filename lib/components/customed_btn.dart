import 'package:flutter/material.dart';
import 'package:trader/variables/myvariables.dart';

Widget settingButton(String value, IconData data, VoidCallback callback) {
  return GestureDetector(
    onTap: callback,
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(color42),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              offset: const Offset(0, 8),
              color: const Color(0xff7090b0).withAlpha(20),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(
                  data,
                  size: 45,
                  color: Colors.white,
                ),
              ),
              Text(
                (value + "...").substring(0, 6),
                textDirection: textDirection,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
