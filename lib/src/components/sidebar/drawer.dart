import 'package:flutter/material.dart';
import 'package:repository_ustp/src/auth/logout/logout_function.dart';
import 'package:repository_ustp/src/components/confirmation_dialog.dart';
import 'package:repository_ustp/src/components/sidebar/components/header_container.dart';
import 'package:repository_ustp/src/components/sidebar/modules/add_footer_icon.dart';
import 'package:repository_ustp/src/components/sidebar/modules/add_item_list.dart';
import 'package:repository_ustp/src/components/sidebar/modules/add_user_type.dart';
import 'package:repository_ustp/src/components/textbutton_icon.dart';
import 'package:repository_ustp/src/utils/palette.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key, required this.callback});
  final Function callback;

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorPallete.secondary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const SideBarHeaderContainer(),
                addUserType(),
                addItemList(widget.callback, context),
              ],
            ),
          ),
          CustomListTileItems(
            callback: () async {
              const title = "CONFIRM LOG-OUT";
              const content = "Are you sure you want to logout ?";
              await confirmationDialog(context, title, content, logout);
            },
            icon: addPreffixIcon(Icons.exit_to_app),
            label: addLabel("LOG-OUT"),
          ),
        ],
      ),
    );
  }
}
