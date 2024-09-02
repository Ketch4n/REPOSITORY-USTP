import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/sidebar/sidebar.dart';
import 'package:repository_ustp/src/data/screen_breakpoint.dart';
import 'package:repository_ustp/src/data/session.dart';
import 'package:repository_ustp/src/pages/capstone_teams/capstone_teams_page.dart';
import 'package:repository_ustp/src/pages/index/components/card_list.dart';
import 'package:repository_ustp/src/pages/index/components/search_field.dart';
import 'package:repository_ustp/src/pages/index/modules/add_appbar.dart';
import 'package:repository_ustp/src/pages/index/modules/add_showsearch.dart';
import 'package:repository_ustp/src/pages/projects/project_page.dart';
import 'package:repository_ustp/src/pages/repository/repository_page.dart';
import 'package:repository_ustp/src/pages/students/students_page.dart';
import 'package:repository_ustp/src/utils/palette.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key, this.type});
  final int? type;

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int widgetIndex = 0;

  bool showTopItems = true;
  void _onMenuItemTap(int index) {
    setState(() {
      widgetIndex = index;
    });
  }

  void _onCardItemTap(int index) {
    setState(() {
      CardTypeClick.quack = index;
    });
  }

  _onTapShowItems() {
    setState(() {
      showTopItems = !showTopItems;
      // customSnackBar(context, 0, "Clicked");
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorPallete.grey,
      appBar: width <= tabletBreakpoint
          ? addAppBar(
              _onTapShowItems,
              showTopItems,
            )
          : null,
      drawer:
          width <= tabletBreakpoint ? SideBar(callback: _onMenuItemTap) : null,
      body: _buildBody(width, _onMenuItemTap, widgetIndex, _onCardItemTap,
          CardTypeClick.quack, showTopItems, _onTapShowItems),
    );
  }
}

Widget _buildBody(width, onMenuItemTap, widgetIndex, onCardItemTap, quack,
    showTopItems, onTapShowItems) {
  return Row(
    children: <Widget>[
      _buildSidebar(width, onMenuItemTap),
      _buildContent(width, widgetIndex, onCardItemTap, quack, showTopItems,
          onTapShowItems, onMenuItemTap),
    ],
  );
}

Widget _buildSidebar(width, onMenuItemTap) {
  return width > tabletBreakpoint
      ? SideBar(callback: onMenuItemTap)
      : const SizedBox();
}

Widget _buildContent(width, widgetIndex, onCardItemTap, quack, showTopItems,
    onTapShowItems, onMenuItemTap) {
  return Expanded(
    child: Scaffold(
      backgroundColor: ColorPallete.grey,
      floatingActionButton: width > tabletBreakpoint
          ? addShowSearch(
              onTapShowItems,
              showTopItems && width > tabletBreakpoint
                  ? const Icon(Icons.fullscreen)
                  : !showTopItems && width > tabletBreakpoint
                      ? const Icon(Icons.search)
                      : const SizedBox(),
              showTopItems && width > tabletBreakpoint
                  ? const Text("Fullscreen")
                  : !showTopItems && width > tabletBreakpoint
                      ? const Text("Show Search")
                      : const SizedBox())
          : null,
      floatingActionButtonLocation: showTopItems && width > tabletBreakpoint
          ? FloatingActionButtonLocation.miniEndDocked
          : FloatingActionButtonLocation.miniEndTop,
      body: _buildSubContent(
          showTopItems, onCardItemTap, widgetIndex, quack, onMenuItemTap),
    ),
  );
}

Widget _buildSubContent(
    showTopItems, onCardItemTap, widgetIndex, quack, onMenuItemTap) {
  return Column(
    children: [
      showTopItems ? const SearchField() : const SizedBox(),
      showTopItems
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: CardList(callback: onCardItemTap),
            )
          : const SizedBox(),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: IndexedStack(
            index: widgetIndex,
            children: <Widget>[
              ProjectPage(projectType: quack),
              RepositoryPage(
                // callback: onMenuItemTap,
                projectType: quack,
              ),
              const CapstoneTeamsPage(),
              const StudentsPage(status: 0),
              const StudentsPage(status: 1),
            ],
          ),
        ),
      )
    ],
  );
}
