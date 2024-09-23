import 'package:flutter/material.dart';
import 'package:repository_ustp/src/utils/palette.dart';

class PageConfirmContainer extends StatefulWidget {
  const PageConfirmContainer({super.key, required this.children});
  final List<Widget> children;

  @override
  State<PageConfirmContainer> createState() => _PageConfirmContainerState();
}

class _PageConfirmContainerState extends State<PageConfirmContainer> {
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
          children: widget.children.map((child) => child).toList(),
        ),
      ),
    );
  }
}
