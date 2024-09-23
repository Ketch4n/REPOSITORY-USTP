import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/button.dart';
import 'package:repository_ustp/src/components/textbutton.dart';
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
                      height: 150,
                      width: 100,
                      child: Image.asset("assets/hardbound.png")),
                  Text(pages.capstoneTitle.text)
                ],
              ),
            ),
            Container(
              width: double.maxFinite,
              color: ColorPallete.grey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                      leading: const Text("PROJECT TYPE"),
                      trailing: Text(pages.projectType.text)),
                  ListTile(
                    leading: const Text("YEAR PUBLISHED"),
                    trailing: Text(pages.yearPublished.text),
                  ),
                ],
              ),
            ),
            Container(
              width: double.maxFinite,
              color: ColorPallete.grey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                      leading: const Text("GROUP NAME"),
                      trailing: Text(pages.groupName.text)),
                  ListTile(
                    leading: const Text("AUTHORS"),
                    trailing: Text(pages.authors.text[0]),
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
