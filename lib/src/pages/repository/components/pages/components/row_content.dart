import 'package:flutter/material.dart';

class Page4RowContent extends StatelessWidget {
  const Page4RowContent({super.key, required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: children.map((child) => child).toList(),
    );
  }
}
