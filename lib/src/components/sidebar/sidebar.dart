import 'package:flutter/material.dart';
import 'package:repository_ustp/src/auth/logout/logout_function.dart';
import 'package:repository_ustp/src/components/confirmation_dialog.dart';
import 'package:repository_ustp/src/components/sidebar/components/header_container.dart';
import 'package:repository_ustp/src/components/sidebar/sidebar_module.dart';
import 'package:repository_ustp/src/utils/palette.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      constraints: const BoxConstraints(maxWidth: 230),
      child: Drawer(
        backgroundColor: ColorPallete.secondary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHeaderContent(),
            _buildExitIcon(context),
          ],
        ),
      ),
    ));
  }
}

Widget _buildHeaderContent() {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildHeaderContainer(),
      ],
    ),
  );
}

Widget _buildHeaderContainer() {
  return const SideBarHeaderContainer();
}

Widget _buildExitIcon(context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
    child: TextButton.icon(
      onPressed: () async {
        const title = "CONFIRM LOG-OUT";
        const content = "Are you sure you want to logout ?";
        await confirmationDialog(context, title, content, logout);
      },
      icon: addExitIcon(),
      label: addTextButton(),
    ),
  );
}
