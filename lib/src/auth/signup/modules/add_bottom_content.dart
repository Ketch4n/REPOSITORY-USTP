import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/button.dart';
import 'package:repository_ustp/src/components/textbutton.dart';

Widget addBottomContent(context, callback) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(
        width: double.maxFinite,
        child: CustomButton(
          callback: callback,
          child: const Text("REGISTER"),
        ),
      ),
      const SizedBox(height: 30),
      CustomTextButton(
          text: "Already have an account ?",
          callback: () {
            Navigator.of(context).pop();
          })
    ],
  );
}
