import 'package:flutter/material.dart';
import 'package:repository_ustp/src/utils/text.dart';

class DuckNada extends StatelessWidget {
  const DuckNada({super.key, required this.status, required this.content});
  final String status;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 60, bottom: 30),
          child: SizedBox(
            height: 80,
            width: 80,
            child: Image.asset(
              "assets/nada.gif",
            ),
          ),
        ),
        Text(
          status,
          style: CustomTextStyle.subtext,
        ),
        Text(content),
      ],
    );
  }
}
