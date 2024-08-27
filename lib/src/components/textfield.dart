import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.label,
    this.hint,
    required this.controller,
    this.obscure,
    this.suffix,
  });
  final String? label;
  final String? hint;

  final TextEditingController controller;
  final bool? obscure;
  final Widget? suffix;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.hint == null ? 60 : 40,
      width: widget.hint == null ? null : 120,
      child: TextField(
        obscureText: widget.obscure ?? false,
        controller: widget.controller,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          labelText: widget.label,
          hintText: widget.hint,
          hintStyle: const TextStyle(fontSize: 15),
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          fillColor: Colors.white,
          filled: true,
          suffixIcon: widget.suffix,
        ),
      ),
    );
  }
}
