import 'package:flutter/material.dart';
import 'package:repository_ustp/src/utils/palette.dart';

class SideBarHeaderContainer extends StatelessWidget {
  const SideBarHeaderContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorPallete.primary,
      child: const SizedBox(
        height: 140,
        width: double.maxFinite,
        // child: Image.asset(
        //   'assets/images/neon.jpg',
        //   fit: BoxFit.cover,
        // ),
      ),
    );
  }
}
