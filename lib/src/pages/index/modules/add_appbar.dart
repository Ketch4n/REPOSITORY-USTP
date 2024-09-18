import 'package:flutter/material.dart';
import 'package:repository_ustp/src/utils/palette.dart';
import 'package:repository_ustp/src/utils/text.dart';

AppBar addAppBar(onTapShowItems, showTopItems) {
  return AppBar(
    title: Text("PROJECT REPOSITORY", style: CustomTextStyle.iconLabel),
    centerTitle: true,
    // actions: [
    //   IconButton(
    //     onPressed: () {
    //       onTapShowItems();
    //     },
    //     icon: showTopItems
    //         ? const Icon(Icons.search_off)
    //         : const Icon(Icons.search),
    //   )
    // ],
    backgroundColor: ColorPallete.secondary,
  );
}
