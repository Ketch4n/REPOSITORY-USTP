import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/button.dart';
import 'package:repository_ustp/src/components/textbutton.dart';

class PageViewButtons extends StatefulWidget {
  const PageViewButtons({
    super.key,
    required this.flabel,
    required this.blabel,
    required this.ffunction,
    required this.bfunction,
  });
  final String flabel;
  final String blabel;
  final Function ffunction;
  final Function bfunction;

  @override
  State<PageViewButtons> createState() => _PageViewButtonsState();
}

class _PageViewButtonsState extends State<PageViewButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
            flex: 2,
            child: CustomTextButton(
                text: widget.blabel,
                callback: () {
                  widget.bfunction();
                })),
        Flexible(
            flex: 2,
            child: CustomButton(
              child: Text(widget.flabel),
              callback: () {
                widget.ffunction();
              },
            ))
      ],
    );
  }
}
