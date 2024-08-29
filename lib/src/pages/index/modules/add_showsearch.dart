import 'package:flutter/material.dart';

Widget addShowSearch(onTapShowItems, icon, label) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 15.0),
    child: TextButton.icon(
      onPressed: () {
        onTapShowItems();
      },
      icon: icon,
      label: label,
    ),
  );
}
