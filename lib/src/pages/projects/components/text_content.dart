// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class TextContent extends StatelessWidget {
  const TextContent({
    super.key,
    required this.alignment,
    required this.title,
    this.color,
    this.size,
  });
  final alignment;
  final String title;
  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          title,
          style: TextStyle(color: color ?? Colors.white, fontSize: size),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
