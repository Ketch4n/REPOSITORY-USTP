import 'package:flutter/material.dart';

Widget addTitle(text, topPadding) {
  return Padding(
    padding: EdgeInsets.only(
        left: 16.0, right: 16.0, top: topPadding ?? 10, bottom: 20),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    ),
  );
}
