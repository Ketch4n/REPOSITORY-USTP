import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repository_ustp/src/components/snackbar.dart';
import 'package:repository_ustp/src/data/provider/author_list.dart';
import 'package:repository_ustp/src/data/provider/project_type_add.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/components/bottom_buttons.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/components/container.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/components/row_content.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/class/text_editing_controller.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/components/text_style.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/utils/page4_container_style.dart';
import 'package:repository_ustp/src/pages/repository/repository_function.dart';

class RepositoryConfirm extends StatefulWidget {
  const RepositoryConfirm({
    super.key,
    required this.backward,
    required this.reload,
  });
  final Function backward;
  final Function reload;

  @override
  State<RepositoryConfirm> createState() => _RepositoryConfirmState();
}

class _RepositoryConfirmState extends State<RepositoryConfirm> {
  final pages = PagesTextEditingController();

  void submit(BuildContext context, int? projectType, List<String?> authors,
      Function reload) async {
    // Storing text input to variables for readability
    final capstoneTitle = pages.capstoneTitle.text;
    final yearPublished = pages.yearPublished.text;
    final groupName = pages.groupName.text;

    // Input validation
    if (capstoneTitle.isEmpty ||
        projectType == null ||
        projectType == 0 ||
        yearPublished.isEmpty ||
        groupName.isEmpty) {
      customSnackBar(context, 1, "Cannot add empty fields");
      return;
    }

    try {
      // Call the repository function to submit the project
      var output = await RepositoryFunction.postProject(
        context,
        capstoneTitle,
        projectType,
        yearPublished,
        groupName,
        authors,
      );

      if (!context.mounted) return;

      if (output != false) {
        // await widget.upload();
      }

      Navigator.of(context).pop(); // Close dialog or navigate back
      reload(); // Trigger a reload
      _clear(); // Clear fields
    } catch (e) {
      print("Submission Error: $e"); // Log error
    }
  }

  void _clear() {
    pages.capstoneTitle.clear();
    pages.yearPublished.clear();
    pages.groupName.clear();
    pages.projectType.clear();
    pages.authors.clear();
    pages.manuscript.clear();
    pages.video.clear();
    pages.poster.clear();
  }

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
            SizedBox(
              child: Column(
                children: [
                  _index1(pages.projectType.text, pages.yearPublished.text),
                  const SizedBox(height: 20),
                  _index2(pages.groupName.text, pages.authors.text),
                  const SizedBox(height: 20),
                  _index3(pages.manuscript.text, pages.poster.text,
                      pages.video.text),
                ],
              ),
            ),
            Consumer2<ProjectTypeAdd, AuthorList>(
                builder: (context, value, value2, child) {
              return PageViewButtons(
                flabel: "CONFIRM AND SAVE",
                blabel: 'PREVIOUS',
                ffunction: () => submit(
                    context, value.quackNew, value2.authors, widget.reload),
                bfunction: () => widget.backward(),
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

Widget _index3(doc, img, clip) {
  return PageConfirmContainer(
    children: [
      Page4RowContent(
        children: [
          const Text("MANUSCRIPT"),
          Page4TextModule(string: doc),
        ],
      ),
      Page4RowContent(
        children: [
          const Text("POSTER"),
          Page4TextModule(string: img),
        ],
      ),
      Page4RowContent(
        children: [
          const Text("VIDEOS"),
          Page4TextModule(string: clip),
        ],
      ),
    ],
  );
}
