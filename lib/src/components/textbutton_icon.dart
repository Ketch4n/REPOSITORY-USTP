import 'package:flutter/material.dart';

class CustomListTileItems extends StatelessWidget {
  const CustomListTileItems({
    super.key,
    required this.callback,
    required this.icon,
    required this.label,
  });
  final VoidCallback callback;
  final Icon icon;
  final Text label;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: label,
      onTap: callback,
    );
  }
}
