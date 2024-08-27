import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/sidebar/drawer.dart';

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
        constraints: const BoxConstraints(maxWidth: 260),
        child: const MyDrawer(),
      ),
    );
  }
}
