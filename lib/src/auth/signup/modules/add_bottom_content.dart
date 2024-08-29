import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/button.dart';
import 'package:repository_ustp/src/components/textbutton.dart';

Widget addBottomContent(context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(
        width: double.maxFinite,
        child: CustomButton(child: const Text("REGISTER"), callback: () {}),
      ),
      const SizedBox(height: 10),
      CustomTextButton(
          text: "Already have an account ?",
          callback: () {
            Navigator.of(context).pop();
          })
    ],
  );
}
