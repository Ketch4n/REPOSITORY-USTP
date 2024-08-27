import 'package:flutter/material.dart';

class CustomTextButtonIcon extends StatelessWidget {
  const CustomTextButtonIcon({
    super.key,
    this.callback,
    required this.icon,
    required this.label,
  });
  final VoidCallback? callback;
  final Icon icon;
  final Text label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: TextButton.icon(
        onPressed: () async {
          callback!();
        },
        icon: icon,
        label: label,
      ),
    );
  }
}
