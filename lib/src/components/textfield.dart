import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.text,
    required this.controller,
    required this.obscure,
    this.suffix,
  });
  final String text;
  final TextEditingController controller;
  final bool obscure;
  final Widget? suffix;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40, bottom: 10),
      child: SizedBox(
        height: 60,
        child: TextFormField(
          obscureText: widget.obscure,
          controller: widget.controller,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
            labelText: widget.text,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            fillColor: Colors.white,
            filled: true,
            suffixIcon: widget.suffix,
          ),
        ),
      ),
    );
  }
}
