import 'package:flutter/material.dart';
import 'package:repository_ustp/src/utils/box_shadow.dart';

class USTPLogo extends StatelessWidget {
  const USTPLogo({
    super.key,
    required this.size,
  });
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        boxShadow: [CustomBoxShadow.value],
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.asset("assets/ustp_logo.jpg"),
      ),
    );
  }
}
