import 'package:flutter/material.dart';
import 'package:repository_ustp/src/auth/login/modules/add_title.dart';
import 'package:repository_ustp/src/components/textfield.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/class/text_editing_controller.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/components/bottom_buttons.dart';

class Page3 extends StatefulWidget {
  const Page3({super.key, required this.backward, required this.forward});
  final Future<void> Function() backward;
  final Future<void> Function() forward;

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  final pages = PagesTextEditingController();
  // @override
  // void dispose() {
  //   pages.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          addTitle("ADD NEW REPOSITORY", 20),
          SizedBox(
            child: Column(
              children: [
                CustomTextField(
                  controller: pages.capstoneTitle,
                  label: "Capstone Title",
                  readOnly: false,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: pages.capstoneTitle,
                  label: "Capstone Title",
                  readOnly: false,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: pages.capstoneTitle,
                  label: "Capstone Title",
                  readOnly: false,
                ),
              ],
            ),
          ),
          PageViewButtons(
            flabel: "NEXT",
            blabel: 'PREVIOUS',
            ffunction: () => widget.forward(),
            bfunction: () => widget.backward(),
          ),
        ],
      ),
    );
  }
}
