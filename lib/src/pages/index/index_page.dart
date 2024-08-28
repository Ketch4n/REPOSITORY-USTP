import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/duck_404.dart';
import 'package:repository_ustp/src/components/sidebar/sidebar.dart';
import 'package:repository_ustp/src/data/screen_breakpoint.dart';
import 'package:repository_ustp/src/pages/index/components/card_list.dart';
import 'package:repository_ustp/src/pages/index/components/search_field.dart';
import 'package:repository_ustp/src/pages/index/modules/add_appbar.dart';
import 'package:repository_ustp/src/utils/palette.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key, this.type});
  final int? type;

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int widgetIndex = 0;
  String quack = "Quack";
  void _onMenuItemTap(int index) {
    setState(() {
      widgetIndex = index;
    });
  }

  void _onCardItemTap(String index) {
    setState(() {
      quack = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorPallete.grey,
      appBar: width <= tabletBreakpoint ? addAppBar() : null,
      drawer:
          width <= tabletBreakpoint ? SideBar(callback: _onMenuItemTap) : null,
      body:
          _buildBody(width, _onMenuItemTap, widgetIndex, _onCardItemTap, quack),
    );
  }
}

Widget _buildBody(width, onMenuItemTap, widgetIndex, onCardItemTap, quack) {
  return Row(
    children: <Widget>[
      _buildSidebar(width, onMenuItemTap),
      _buildContent(widgetIndex, onCardItemTap, quack),
    ],
  );
}

Widget _buildSidebar(width, onMenuItemTap) {
  return width > tabletBreakpoint
      ? SideBar(callback: onMenuItemTap)
      : const SizedBox();
}

Widget _buildContent(widgetIndex, onCardItemTap, quack) {
  return Expanded(
    child: Scaffold(
      backgroundColor: ColorPallete.grey,
      body: Column(
        children: [
          const SearchField(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: CardList(callback: onCardItemTap),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: IndexedStack(
                children: [
                  Duck(status: widgetIndex.toString(), content: quack),
                  Duck(status: widgetIndex.toString(), content: quack),
                  Duck(status: widgetIndex.toString(), content: quack),
                  Duck(status: widgetIndex.toString(), content: quack),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}
