import 'package:flutter/material.dart';
import 'package:repository_ustp/src/utils/text.dart';

Icon addPreffixIcon(icon) {
  return Icon(
    icon,
    color: Colors.black,
  );
}

Text addLabel(label) {
  return Text(
    label,
    style: CustomTextStyle.iconLabel,
  );
}
