import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/duck_404.dart';
import 'package:repository_ustp/src/components/sidebar/sidebar.dart';
import 'package:repository_ustp/src/data/screen_breakpoint.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key, this.type});
  final int? type;

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int widgetIndex = 0;
  void _onMenuItemTap(int index) {
    setState(() {
      widgetIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: width <= tabletBreakpoint ? AppBar() : null,
        drawer: width <= tabletBreakpoint
            ? SideBar(
                callback: _onMenuItemTap,
              )
            : null,
        body: Row(
          children: <Widget>[
            width > tabletBreakpoint
                ? SideBar(
                    callback: _onMenuItemTap,
                  )
                : const SizedBox(),
            Expanded(
              child: Scaffold(
                body: IndexedStack(
                  index: widgetIndex,
                  children: const [
                    Duck(status: "0", content: "Quack Quack"),
                    Duck(status: "1", content: "Quack Quack"),
                    Duck(status: "2", content: "Quack Quack"),
                    Duck(status: "3", content: "Quack Quack"),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
