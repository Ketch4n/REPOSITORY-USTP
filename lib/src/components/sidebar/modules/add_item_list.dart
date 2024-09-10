import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/sidebar/modules/add_footer_icon.dart';
import 'package:repository_ustp/src/components/textbutton_icon.dart';
import 'package:repository_ustp/src/utils/screen_breakpoint.dart';

import 'package:repository_ustp/src/data/provider/user_session.dart';

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
      const Divider(),
      UserSession.type != 2
          ? CustomListTileItems(
              icon: addPreffixIcon(Icons.lock_person),
              label: addLabel("Student Access"),
              callback: () {
                callback(3);
                mobile ? Navigator.of(context).pop() : null;
              },
            )
          : const SizedBox(),
      UserSession.type != 2
          ? CustomListTileItems(
              icon: addPreffixIcon(Icons.no_accounts_rounded),
              label: addLabel("Archived"),
              callback: () {
                callback(4);
                mobile ? Navigator.of(context).pop() : null;
              },
            )
          : const SizedBox(),
      const Divider(),
      UserSession.type != 2
          ? CustomListTileItems(
              icon: addPreffixIcon(Icons.cloud_download),
              label: addLabel("Cloud Back-up"),
              callback: () {
                callback(5);
                mobile ? Navigator.of(context).pop() : null;
              },
            )
          : const SizedBox(),
    ],
  );
}
