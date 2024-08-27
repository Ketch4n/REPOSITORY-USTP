import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/sidebar/drawer.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key, required this.callback});
  final Function callback;

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        constraints: const BoxConstraints(maxWidth: 260),
        child: MyDrawer(callback: widget.callback),
      ),
    );
  }
}
