import 'package:flutter/material.dart';
import 'package:repository_ustp/src/auth/login/modules/add_title.dart';
import 'package:repository_ustp/src/components/button.dart';
import 'package:repository_ustp/src/components/textbutton.dart';
import 'package:repository_ustp/src/components/textfield.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/components/text_editing_controller.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key, required this.forward, required this.backward});
  final Future<void> Function() forward;
  final Future<void> Function() backward;

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  bool _visible = false;

  List<String?> lines = [];

  @override
  Widget build(BuildContext context) {
    final pages = PagesTextEditingController();
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
                ),
                const SizedBox(height: 10),
                // CustomTextField(
                //   controller: _authorsController,
                //   label: "Authors",
                // ),
                TextField(
                  controller: pages.authors,
                  keyboardType:
                      TextInputType.multiline, // Allow multiline input
                  maxLines: null,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Authors...',
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
                        lines = text.split('\n');
                        if (lines.length > 4) {
                          lines = lines.sublist(0, 4);
                          pages.authors.text = lines.join('\n');
                          pages.authors.selection = TextSelection.fromPosition(
                            TextPosition(offset: pages.authors.text.length),
                          );
                        }
                      },
                    );
                  },
                ),
                const SizedBox(height: 10),
                _visible
                    ? const Text("maximum of 4 authors (by new line)")
                    : const SizedBox()
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
                      child: const Text("NEXT"),
                      callback: () {
                        widget.forward();
                      }))
            ],
          )
        ],
      ),
    );
  }
}
