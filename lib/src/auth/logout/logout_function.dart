import 'package:flutter/material.dart';

Future logout(context) async {
  Navigator.pushNamedAndRemoveUntil(
    context,
    '/login',
    (route) => false,
  );
}
