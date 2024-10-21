import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:repository_ustp/src/data/provider/author_list.dart';
import 'package:repository_ustp/src/data/provider/project_purpose.dart';
import 'package:repository_ustp/src/data/provider/project_type_add.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/class/access_controller_instance.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/components/bottom_buttons.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/components/container.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/components/text_style.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/functions/submit_project.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/utils/page4_container_style.dart';

class RepositoryConfirm extends StatefulWidget {
  const RepositoryConfirm({
    super.key,
    required this.backward,
    required this.reload,
    required this.purposeID,
  });
  final Function backward;
  final Function reload;
  final int purposeID;

  @override
  State<RepositoryConfirm> createState() => _RepositoryConfirmState();
}

class _RepositoryConfirmState extends State<RepositoryConfirm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Page4ContainerStyle.style,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _topContent(pages.capstoneTitle.text),
            Consumer<ProjectPurpose>(builder: (context, value, child) {
              return SizedBox(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _index1(pages.projectType.text, pages.yearPublished.text),
                      const SizedBox(height: 20),
                      _index2(pages.groupName.text, pages.authors.text),
                      const SizedBox(height: 20),
                      value.quackNew == 0
                          ? _index3(pages.manuscript.text, pages.poster.text,
                              pages.video.text, pages.zip.text)
                          : const SizedBox(),
                    ],
                  ),
                ),
              );
            }),
            Consumer2<ProjectTypeAdd, AuthorList>(
                builder: (context, value, value2, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: PageViewButtons(
                  flabel: "CONFIRM AND SAVE",
                  blabel: 'PREVIOUS',
                  ffunction: () {
                    widget.purposeID == 0
                        ? ProjectFunction.submit(context, value.quackNew,
                            value2.authors, widget.reload)
                        : ProjectFunction.update(context, value.quackNew,
                            value2.authors, widget.reload, widget.purposeID);
                  },
                  bfunction: () => widget.backward(),
                ),
              );
            }),
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
            height: 100, width: 50, child: Image.asset("assets/hardbound.png")),
        Page4TextModule(string: title),
      ],
    ),
  );
}

Widget _index1(type, year) {
  return PageConfirmContainer(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("PROJECT TYPE"),
          Page4TextModule(string: type),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("GROUP NAME"),
          Page4TextModule(string: gname),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("AUTHORS"),
          Page4TextModule(string: authors),
        ],
      ),
    ],
  );
}

Widget _index3(doc, img, clip, zip) {
  return PageConfirmContainer(
    children: [
      SingleChildScrollView(
        child: Column(
          children: [
            _buildRow("MANUSCRIPT", doc),
            _buildScrollableRow("POSTER", img),
            _buildScrollableRow("VIDEOS", clip),
            _buildRow("SOURCE CODE", zip),
          ],
        ),
      ),
    ],
  );
}

Widget _buildRow(String label, String content) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label),
      Expanded(child: Page4TextModule(string: content)),
    ],
  );
}

Widget _buildScrollableRow(String label, String content) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label),
      Expanded(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Page4TextModule(string: content),
        ),
      ),
    ],
  );
}
