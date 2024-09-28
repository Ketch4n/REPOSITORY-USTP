import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repository_ustp/src/data/provider/show_top_items.dart';
import 'package:repository_ustp/src/utils/palette.dart';
import 'package:repository_ustp/src/utils/text.dart';

addAppBar(context) {
  return AppBar(
    title: Text("PROJECT REPOSITORY", style: CustomTextStyle.iconLabel),
    centerTitle: true,
    actions: [
      Consumer<ShowTopItems>(builder: (context, value, child) {
        return IconButton(
          onPressed: () {
            if (value.isShow) {
              context.read<ShowTopItems>().hide();
            } else {
              context.read<ShowTopItems>().show();
            }
          },
          icon: value.isShow
              ? const Icon(Icons.search_off)
              : const Icon(Icons.search),
        );
      })
    ],
    backgroundColor: ColorPallete.secondary,
  );
}
