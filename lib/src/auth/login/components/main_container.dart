// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:repository_ustp/src/utils/box_shadow.dart';
import 'package:repository_ustp/src/utils/palette.dart';

class LoginMainContainer extends StatelessWidget {
  const LoginMainContainer({
    super.key,
    required this.child,
    this.radius,
  });

  final child;
  final radius;
  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: height - 150,
      constraints: const BoxConstraints(maxWidth: 450, maxHeight: 600),
      decoration: BoxDecoration(
        color: ColorPallete.grey,
        borderRadius: BorderRadius.circular(radius ?? 50),
        boxShadow: [CustomBoxShadow.value],
      ),
      child: child,
    );
  }
}
