import 'package:flutter/material.dart';
import 'package:repository_ustp/src/auth/login/modules/add_title.dart';
import 'package:repository_ustp/src/components/textfield.dart';
import 'package:repository_ustp/src/data/provider/author_list.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/class/text_editing_controller.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/components/bottom_buttons.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key, required this.forward, required this.backward});
  final Future<void> Function() forward;
  final Future<void> Function() backward;

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  final pages = PagesTextEditingController();

  bool _visible = false;

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
                  controller: pages.groupName,
                  label: "Group Name",
                  readOnly: false,
                ),
                const SizedBox(height: 10),
                Container(
                  color: Colors.white,
                  child: TextField(
                    controller: pages.authors,
                    keyboardType:
                        TextInputType.multiline, // Allow multiline input
                    maxLines: null,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      border: const OutlineInputBorder(),
                      labelText: 'Authors...',
                      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _visible = !_visible;
                          });
                        },
                        icon: const Icon(Icons.info_outline),
                      ),
                      fillColor: Colors.white,
                    ),

                    onChanged: (text) {
                      setState(
                        () {
                          AuthorList.lines = text.split('\n');
                          if (AuthorList.lines.length > 4) {
                            AuthorList.lines = AuthorList.lines.sublist(0, 4);
                            pages.authors.text = AuthorList.lines.join('\n');
                            pages.authors.selection =
                                TextSelection.fromPosition(
                              TextPosition(offset: pages.authors.text.length),
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                _visible
                    ? const Text("maximum of 4 authors (Click Enter to add)")
                    : const SizedBox()
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
