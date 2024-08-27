import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/sidebar/modules/add_footer_icon.dart';
import 'package:repository_ustp/src/components/textbutton_icon.dart';

Widget addItemList() {
  return Column(
    children: [
      CustomListTileItems(
        icon: addPreffixIcon(Icons.insert_drive_file_outlined),
        label: addLabel("All Projects"),
        callback: () {},
      ),
      CustomListTileItems(
        icon: addPreffixIcon(Icons.groups),
        label: addLabel("Capstone Teams"),
        callback: () {},
      ),
      CustomListTileItems(
        icon: addPreffixIcon(Icons.folder),
        label: addLabel("Repository"),
        callback: () {},
      ),
      CustomListTileItems(
        icon: addPreffixIcon(Icons.archive_outlined),
        label: addLabel("Archived"),
        callback: () {},
      ),
    ],
  );
}
