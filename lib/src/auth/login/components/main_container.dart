// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:repository_ustp/src/utils/box_shadow.dart';
import 'package:repository_ustp/src/utils/palette.dart';

class LoginMainContainer extends StatelessWidget {
  const LoginMainContainer({
    super.key,
    this.height,
    this.width,
    required this.child,
    this.radius,
  });
  final height;
  final width;
  final child;
  final radius;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 470,
      width: width ?? 450,
      decoration: BoxDecoration(
        color: ColorPallete.grey,
        borderRadius: BorderRadius.circular(radius ?? 50),
        boxShadow: [CustomBoxShadow.value],
      ),
      child: child,
    );
  }
}
