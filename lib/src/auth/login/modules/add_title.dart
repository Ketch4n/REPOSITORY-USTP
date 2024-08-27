import 'package:flutter/material.dart';

Widget addTitle() {
  return const Padding(
    padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 70, bottom: 20),
    child: Text(
      "PROJECT REPOSITORY\nSYSTEM",
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    ),
  );
}
