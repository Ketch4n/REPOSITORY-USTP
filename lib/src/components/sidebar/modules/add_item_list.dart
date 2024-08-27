import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/sidebar/modules/add_footer_icon.dart';
import 'package:repository_ustp/src/components/textbutton_icon.dart';

Widget addItemList(callback) {
  return Column(
    children: [
      CustomListTileItems(
        icon: addPreffixIcon(Icons.insert_drive_file_outlined),
        label: addLabel("All Projects"),
        callback: () {
          callback(0);
        },
      ),
      CustomListTileItems(
        icon: addPreffixIcon(Icons.groups),
        label: addLabel("Capstone Teams"),
        callback: () {
          callback(1);
        },
      ),
      CustomListTileItems(
        icon: addPreffixIcon(Icons.folder),
        label: addLabel("Repository"),
        callback: () {
          callback(2);
        },
      ),
      CustomListTileItems(
        icon: addPreffixIcon(Icons.archive_outlined),
        label: addLabel("Archived"),
        callback: () {
          callback(3);
        },
      ),
    ],
  );
}
