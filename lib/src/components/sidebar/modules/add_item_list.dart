import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/sidebar/modules/add_footer_icon.dart';
import 'package:repository_ustp/src/components/textbutton_icon.dart';
import 'package:repository_ustp/src/data/screen_breakpoint.dart';

Widget addItemList(callback, context) {
  final width = MediaQuery.of(context).size.width;
  final bool mobile = width <= tabletBreakpoint ? true : false;
  return Column(
    children: [
      CustomListTileItems(
        icon: addPreffixIcon(Icons.insert_drive_file_outlined),
        label: addLabel("All Projects"),
        callback: () {
          callback(0);
          mobile ? Navigator.of(context).pop() : null;
        },
      ),
      CustomListTileItems(
        icon: addPreffixIcon(Icons.folder),
        label: addLabel("Repository"),
        callback: () {
          callback(1);
          mobile ? Navigator.of(context).pop() : null;
        },
      ),
      CustomListTileItems(
        icon: addPreffixIcon(Icons.groups),
        label: addLabel("Capstone Teams"),
        callback: () {
          callback(2);
          mobile ? Navigator.of(context).pop() : null;
        },
      ),
      CustomListTileItems(
        icon: addPreffixIcon(Icons.archive_outlined),
        label: addLabel("Archived"),
        callback: () {
          callback(3);
          mobile ? Navigator.of(context).pop() : null;
        },
      ),
    ],
  );
}
