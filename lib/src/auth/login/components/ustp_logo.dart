import 'package:flutter/material.dart';
import 'package:repository_ustp/src/utils/box_shadow.dart';

class USTPLogo extends StatelessWidget {
  const USTPLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      width: 125,
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
