import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.text,
      required this.controller,
      required this.obscure,
      this.suffix});
  final String text;
  final TextEditingController controller;
  final bool obscure;
  final Widget? suffix;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40, bottom: 10),
      child: SizedBox(
        height: 60,
        child: TextField(
          obscureText: obscure,
          controller: controller,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
            labelText: text,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            fillColor: Colors.white,
            filled: true,
            suffixIcon: suffix,
          ),
        ),
      ),
    );
  }
}
