import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.child, required this.callback});
  final Widget child;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.maxFinite,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: HexColor("4B97DE"),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Button border radius
            ),
          ),
          onPressed: () {
            callback();
          },
          child: child),
    );
  }
}
