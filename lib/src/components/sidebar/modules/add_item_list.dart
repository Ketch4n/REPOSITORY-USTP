import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/sidebar/modules/add_footer_icon.dart';
import 'package:repository_ustp/src/components/textbutton_icon.dart';
import 'package:repository_ustp/src/data/screen_breakpoint.dart';
import 'package:repository_ustp/src/data/binary_value.dart';

Widget addItemList(callback, context) {
  final width = MediaQuery.of(context).size.width;
  final bool mobile = width <= tabletBreakpoint ? true : false;
  return Column(
    children: [
      CustomListTileItems(
        icon: addPreffixIcon(Icons.handyman_rounded),
        label: addLabel("Projects"),
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
        icon: addPreffixIcon(Icons.lock_person),
        label: addLabel("Student Access"),
        callback: () {
          callback(3);
          mobile ? Navigator.of(context).pop() : null;
        },
      ),
      UserBinary.defaultValue != 2
          ? CustomListTileItems(
              icon: addPreffixIcon(Icons.archive_outlined),
              label: addLabel("Archived"),
              callback: () {
                callback(4);
                mobile ? Navigator.of(context).pop() : null;
              },
            )
          : const SizedBox(),
    ],
  );
}
