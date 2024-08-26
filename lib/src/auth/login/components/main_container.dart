// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:repository_ustp/src/utils/box_shadow.dart';
import 'package:repository_ustp/src/utils/palette.dart';

class LoginMainContainer extends StatelessWidget {
  const LoginMainContainer(
      {super.key,
      required this.height,
      required this.width,
      required this.child});
  final height;
  final width;
  final child;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: ColorPallete.grey,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [CustomBoxShadow.value],
      ),
      child: child,
    );
  }
}
