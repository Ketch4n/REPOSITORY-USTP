import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/snackbar.dart';
import 'package:repository_ustp/src/components/textbutton.dart';
import 'package:repository_ustp/src/utils/text.dart';

Widget buildFooterTextButton(context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Create new account?",
              style: CustomTextStyle.subtext,
            ),
            CustomTextButton(
                text: "Sign Up",
                callback: () {
                  Navigator.pushNamed(context, '/signup');
                })
          ],
        ),
        CustomTextButton(
          text: "Forgot Password",
          callback: () {
            customSnackBar(context, 1, "Under construction");
          },
        )
      ],
    ),
  );
}
