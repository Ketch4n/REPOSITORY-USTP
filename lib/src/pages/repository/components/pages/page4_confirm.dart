import 'package:flutter/material.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/components/bottom_buttons.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/components/container.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/components/row_content.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/class/text_editing_controller.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/components/text_style.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/utils/page4_container_style.dart';

class RepositoryConfirm extends StatefulWidget {
  const RepositoryConfirm({super.key, required this.backward});
  final Function backward;

  @override
  State<RepositoryConfirm> createState() => _RepositoryConfirmState();
}

class _RepositoryConfirmState extends State<RepositoryConfirm> {
  @override
  Widget build(BuildContext context) {
    final pages = PagesTextEditingController();
    return Container(
      decoration: Page4ContainerStyle.style,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _topContent(pages.capstoneTitle.text),
            SizedBox(
              child: Column(
                children: [
                  _index1(pages.projectType.text, pages.yearPublished.text),
                  const SizedBox(height: 20),
                  _index2(pages.groupName.text, pages.authors.text),
                  const SizedBox(height: 20),
                  _index3(),
                ],
              ),
            ),
            PageViewButtons(
              flabel: "CONFIRM AND SAVE",
              blabel: 'PREVIOUS',
              ffunction: () {},
              bfunction: () => widget.backward(),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _topContent(title) {
  return SizedBox(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
            height: 130, width: 80, child: Image.asset("assets/hardbound.png")),
        Page4TextModule(string: title),
      ],
    ),
  );
}

Widget _index1(type, year) {
  return PageConfirmContainer(
    children: [
      Page4RowContent(
        children: [
          const Text("PROJECT TYPE"),
          Page4TextModule(string: type),
        ],
      ),
      Page4RowContent(
        children: [
          const Text("YEAR PUBLISHED"),
          Page4TextModule(string: year),
        ],
      ),
    ],
  );
}

Widget _index2(gname, authors) {
  return PageConfirmContainer(
    children: [
      Page4RowContent(
        children: [
          const Text("GROUP NAME"),
          Page4TextModule(string: gname),
        ],
      ),
      Page4RowContent(
        children: [
          const Text("AUTHORS"),
          Page4TextModule(string: authors),
        ],
      ),
    ],
  );
}

Widget _index3() {
  return const PageConfirmContainer(
    children: [
      Page4RowContent(
        children: [
          Text("MANUSCRIPT"),
          // Text(pages.projectType.text),
        ],
      ),
      Page4RowContent(
        children: [
          Text("POSTER"),
          // Text(pages.yearPublished.text),
        ],
      ),
      Page4RowContent(
        children: [
          Text("VIDEOS"),
          // Text(pages.yearPublished.text),
        ],
      ),
    ],
  );
}
