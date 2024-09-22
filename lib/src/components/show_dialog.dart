import 'package:flutter/material.dart';

Future showCustomDialog(BuildContext context, child) async {
  await showDialog<bool>(
      context: context,
      builder: (context) {
        return Dialog(
          child: child,
        );
      });
}
