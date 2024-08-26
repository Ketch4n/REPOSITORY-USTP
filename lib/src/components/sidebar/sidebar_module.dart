import 'package:flutter/material.dart';
import 'package:repository_ustp/src/utils/text.dart';

Widget addExitIcon() {
  return const Icon(
    Icons.exit_to_app_rounded,
    color: Colors.black,
  );
}

Widget addTextButton() {
  return Text(
    'Logout',
    style: CustomTextStyle.iconLabel,
  );
}
