import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/sidebar/sidebar.dart';
import 'package:repository_ustp/src/data/screen_breakpoint.dart';
import 'package:repository_ustp/src/data/user_binary_value.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key, this.type});
  final int? type;

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: width <= tabletBreakpoint ? AppBar() : null,
        drawer: width <= tabletBreakpoint ? const SideBar() : null,
        body: Row(
          children: <Widget>[
            width > tabletBreakpoint ? const SideBar() : const SizedBox(),
            Expanded(
              child: Scaffold(
                body: Center(
                  child: Text(
                      userBinaryValue(widget.type ?? UserBinary.defaultValue)),
                ),
              ),
            ),
          ],
        ));
  }
}
