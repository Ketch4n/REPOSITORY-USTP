import 'package:flutter/material.dart';

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
        style: const TextStyle(
          fontSize: 15,
          color: Colors.blue,
        ),
      ),
    );
  }
}
