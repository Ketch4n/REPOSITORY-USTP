import 'package:flutter/material.dart';
import 'package:repository_ustp/src/utils/palette.dart';
import 'package:repository_ustp/src/utils/text.dart';

AppBar addAppBar() {
  return AppBar(
    title: Text("PROJECT REPOSITORY", style: CustomTextStyle.iconLabel),
    centerTitle: true,
    backgroundColor: ColorPallete.secondary,
  );
}
