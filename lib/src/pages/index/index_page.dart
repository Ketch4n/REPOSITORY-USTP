import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/sidebar/sidebar.dart';
import 'package:repository_ustp/src/data/user_binary_value.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key, required this.type});
  final int type;

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: <Widget>[
        const SideBar(),
        Expanded(
          child: Scaffold(
            body: Center(
              child: Text(userBinaryValue(widget.type)),
            ),
          ),
        ),
      ],
    ));
  }
}
