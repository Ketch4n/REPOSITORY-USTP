import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/button.dart';
import 'package:repository_ustp/src/components/textbutton.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/components/container.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/components/text_editing_controller.dart';
import 'package:repository_ustp/src/utils/palette.dart';

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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                      height: 130,
                      width: 80,
                      child: Image.asset("assets/hardbound.png")),
                  Text(pages.capstoneTitle.text),
                  Text("(Title)"),
                ],
              ),
            ),
            SizedBox(
              child: Column(
                children: [
                  PageConfirmContainer(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("PROJECT TYPE"),
                          Text(pages.projectType.text)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("YEAR PUBLISHED"),
                          Text(pages.yearPublished.text),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  PageConfirmContainer(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("GROUP NAME"),
                          Text(pages.groupName.text)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("AUTHORS"),
                          Text(pages.authors.text),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  PageConfirmContainer(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("MANUSCRIPT"),
                          Text(pages.projectType.text)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("POSTER"),
                          Text(pages.yearPublished.text),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("VIDEOS"),
                          Text(pages.yearPublished.text),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    flex: 2,
                    child: CustomTextButton(
                        text: 'PREVIOUS',
                        callback: () {
                          widget.backward();
                        })),
                Flexible(
                    flex: 2,
                    child: CustomButton(
                        child: const Text("CONFIRM AND SAVE"), callback: () {}))
              ],
            )
          ],
        ),
      ),
    );
  }
}
