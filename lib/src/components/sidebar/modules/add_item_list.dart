import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/sidebar/modules/add_footer_icon.dart';
import 'package:repository_ustp/src/components/textbutton_icon.dart';
import 'package:repository_ustp/src/utils/screen_breakpoint.dart';

Widget addItemList(callback, context) {
  final width = MediaQuery.of(context).size.width;
  final bool mobile = width <= tabletBreakpoint ? true : false;
  return Column(
    children: [
      CustomListTileItems(
        icon: addPreffixIcon(Icons.folder),
        label: addLabel("Repository"),
        callback: () {
          callback(0);
          mobile ? Navigator.of(context).pop() : null;
        },
      ),
      CustomListTileItems(
        icon: addPreffixIcon(Icons.groups),
        label: addLabel("Project Teams"),
        callback: () {
          callback(1);
          mobile ? Navigator.of(context).pop() : null;
        },
      ),
      const Divider(),
      CustomListTileItems(
        icon: addPreffixIcon(Icons.notifications_active),
        label: addLabel("Active Users"),
        callback: () {
          callback(2);
          mobile ? Navigator.of(context).pop() : null;
        },
      ),
      CustomListTileItems(
        icon: addPreffixIcon(Icons.no_accounts_rounded),
        label: addLabel("Archived Users"),
        callback: () {
          callback(3);
          mobile ? Navigator.of(context).pop() : null;
        },
      ),
      const Divider(),
      CustomListTileItems(
        icon: addPreffixIcon(Icons.cloud_download),
        label: addLabel("Cloud Back-up"),
        callback: () {
          callback(4);
          mobile ? Navigator.of(context).pop() : null;
        },
      ),
      // CustomListTileItems(
      //   icon: addPreffixIcon(Icons.mail),
      //   label: addLabel("Email"),
      //   callback: () async {
      //     // const name = "Quack";
      //     // const email = "mangao.christian.04@gmail.com";
      //     // const message = "New Repository added, check it now !";
      //     // sendEmail(name, email, message);
      //     const title = "Send Email to All";
      //     const content = "only active users can received emails";

      //     var output = await confirmationDialog(context, title, content, () {
      //       SendMailFunction.sendEmailTypeStatus();
      //     });
      //     if (output == true) {
      //       customSnackBar(context, 0, "Email Sent Successfully");
      //     }
      //     mobile ? Navigator.of(context).pop() : null;
      //   },
      // ),
    ],
  );
}
