import 'package:flutter/material.dart';
import 'package:repository_ustp/src/auth/login/modules/add_title.dart';
import 'package:repository_ustp/src/components/button.dart';
import 'package:repository_ustp/src/components/textbutton.dart';
import 'package:repository_ustp/src/components/textfield.dart';
import 'package:repository_ustp/src/data/index/project_index_value.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/components/text_editing_controller.dart';

class Page3 extends StatefulWidget {
  const Page3({super.key, required this.backward, required this.forward});
  final Future<void> Function() backward;
  final Future<void> Function() forward;

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  final _projectType = PagesTextEditingController().projectType;

  int? _selectedItem;

  final List<int> _items = [1, 2, 3];
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
                const SizedBox(height: 10),
                CustomTextField(
                  controller: _projectType,
                  label: "Project Type",
                  suffix: PopupMenuButton<int>(
                    icon: const Icon(Icons.menu),
                    onSelected: (int value) {
                      setState(() {
                        _selectedItem = value;
                        _projectType.text = projectTypeBinaryValue(value);
                      });
                    },
                    itemBuilder: (BuildContext context) {
                      return _items.map((int type) {
                        return PopupMenuItem<int>(
                          value: type,
                          child: Text(projectTypeBinaryValue(type)),
                        );
                      }).toList();
                    },
                  ),
                ),
                const SizedBox(height: 10),
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
