import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/sidebar/sidebar.dart';
import 'package:repository_ustp/src/data/provider/card_click_event.dart';
import 'package:repository_ustp/src/utils/screen_breakpoint.dart';
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

int widgetIndex = 0;
bool showTopItems = true;

class _IndexPageState extends State<IndexPage> {
  void _onMenuItemTap(int index) {
    setState(() {
      widgetIndex = index;
    });
  }

  void _onCardItemTap(int index) {
    setState(() {
      CardClickEvent.quack = index;
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
          ? addAppBar(_onTapShowItems, showTopItems)
          : null,
      drawer:
          width <= tabletBreakpoint ? SideBar(callback: _onMenuItemTap) : null,
      body: _buildBody(width, _onMenuItemTap, _onCardItemTap, _onTapShowItems),
    );
  }
}

Widget _buildBody(width, onMenuItemTap, onCardItemTap, onTapShowItems) {
  return Row(
    children: <Widget>[
      _buildSidebar(width, onMenuItemTap),
      _buildContent(width, onCardItemTap, onTapShowItems, onMenuItemTap),
    ],
  );
}

Widget _buildSidebar(width, onMenuItemTap) {
  return width > tabletBreakpoint
      ? SideBar(callback: onMenuItemTap)
      : const SizedBox();
}

Widget _buildContent(width, onCardItemTap, onTapShowItems, onMenuItemTap) {
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
      body: _buildSubContent(onCardItemTap, onMenuItemTap),
    ),
  );
}

Widget _buildSubContent(onCardItemTap, onMenuItemTap) {
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
              ProjectPage(projectType: CardClickEvent.quack),
              RepositoryPage(
                  // callback: onMenuItemTap,
                  projectType: CardClickEvent.quack),
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
