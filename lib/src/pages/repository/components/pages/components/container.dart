import 'package:flutter/material.dart';
import 'package:repository_ustp/src/utils/palette.dart';

class PageConfirmContainer extends StatelessWidget {
  const PageConfirmContainer({super.key, required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      color: ColorPallete.grey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: children.map((child) => child).toList(),
        ),
      ),
    );
  }
}
