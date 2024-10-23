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
            _topContent(),
            Consumer<ProjectPurpose>(builder: (context, value, child) {
              return SizedBox(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _index1(),
                      const SizedBox(height: 20),
                      _index2(),
                      const SizedBox(height: 20),
                      value.quackNew == 0 ? _index3() : const SizedBox(),
                    ],
                  ),
                ),
              );
            }),
            Consumer3<ProjectTypeAdd, AuthorList, ProjectSemesterAdd>(
                builder: (context, value, value2, value3, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: PageViewButtons(
                  flabel: "CONFIRM AND SAVE",
                  blabel: 'PREVIOUS',
                  ffunction: () {
                    widget.purposeID == 0
                        ? ProjectFunction.submit(context, value.quackNew,
                            value2.authors, value3.quackNew, widget.reload)
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

Widget _topContent() {
  return SizedBox(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
            height: 100, width: 50, child: Image.asset("assets/hardbound.png")),
        Page4TextModule(string: pages.capstoneTitle.text),
      ],
    ),
  );
}

Widget _index1() {
  return PageConfirmContainer(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("PROJECT TYPE"),
          Page4TextModule(string: pages.projectType.text),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("YEAR PUBLISHED"),
          Page4TextModule(string: pages.yearPublished.text),
        ],
      ),
      Consumer<ProjectTypeAdd>(builder: (context, value, child) {
        return value.quackNew == 3
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("SCHOOL YEAR"),
                  Page4TextModule(string: pages.schoolYear.text),
                ],
              )
            : const SizedBox();
      }),
    ],
  );
}

Widget _index2() {
  return PageConfirmContainer(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("GROUP NAME"),
          Page4TextModule(string: pages.groupName.text),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("AUTHORS"),
          Page4TextModule(string: pages.authors.text),
        ],
      ),
    ],
  );
}

Widget _index3() {
  return PageConfirmContainer(
    children: [
      SingleChildScrollView(
        child: Column(
          children: [
            _buildRow("MANUSCRIPT", pages.manuscript.text),
            _buildScrollableRow("POSTER", pages.poster.text),
            _buildScrollableRow("VIDEOS", pages.video.text),
            _buildRow("SOURCE CODE", pages.zip.text),
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
