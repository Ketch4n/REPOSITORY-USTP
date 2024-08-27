import 'package:flutter/material.dart';
import 'package:repository_ustp/src/utils/palette.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {super.key, required this.text, required this.callback});
  final String text;
  final VoidCallback callback;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        callback();
      },
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          color: ColorPallete.primary,
        ),
      ),
    );
  }
}
