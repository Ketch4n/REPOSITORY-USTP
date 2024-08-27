import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/sidebar/sidebar.dart';
import 'package:repository_ustp/src/components/textfield.dart';
import 'package:repository_ustp/src/data/screen_breakpoint.dart';
import 'package:repository_ustp/src/utils/palette.dart';
import 'package:repository_ustp/src/utils/text.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key, this.type});
  final int? type;

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final TextEditingController _controller = TextEditingController();
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
        appBar: width <= tabletBreakpoint
            ? AppBar(
                title: Text("PROJECT REPOSITORY",
                    style: CustomTextStyle.iconLabel),
                centerTitle: true,
                backgroundColor: ColorPallete.secondary,
              )
            : null,
        drawer: width <= tabletBreakpoint
            ? SideBar(callback: _onMenuItemTap)
            : null,
        body: Row(
          children: <Widget>[
            width > tabletBreakpoint
                ? SideBar(callback: _onMenuItemTap)
                : const SizedBox(),
            Expanded(
              child: Scaffold(
                backgroundColor: ColorPallete.grey,
                body: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Wrap(
                          runSpacing: 10.0,
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.center,
                          children: [
                            SizedBox(
                              width: 200,
                              child: CustomTextField(
                                controller: _controller,
                                hint: "SEARCH",
                              ),
                            ),
                            const SizedBox(width: 10),
                            CustomTextField(
                              controller: _controller,
                              hint: "ALL",
                            ),
                            const SizedBox(width: 10),
                            CustomTextField(
                              controller: _controller,
                              hint: "KEYWORD",
                            ),
                            const SizedBox(width: 10),
                            CustomTextField(
                              controller: _controller,
                              hint: "FILES",
                            ),
                            const SizedBox(width: 10),
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.search),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
