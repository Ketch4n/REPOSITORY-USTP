import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/textfield.dart';
import 'package:repository_ustp/src/data/index/project_index_value.dart';
import 'package:repository_ustp/src/data/provider/project_type_add.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/class/access_controller_instance.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/class/clear_controllers.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/components/bottom_buttons.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/modules/pages_title.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key, required this.forward, required this.reload});
  final Function forward;
  final Function reload;

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  final List<int> _items = [1, 2, 3];

  void _cancel() async {
    ClearTextEditingControllers.clear();
    Navigator.of(context).pop();
    widget.reload();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const PagesTitle(),
          SizedBox(
            child: Column(
              children: [
                _index1(pages.capstoneTitle),
                CustomTextField(
                  controller: pages.projectType,
                  readOnly: true,
                  label: "Project Type",
                  suffix: PopupMenuButton<int>(
                    icon: const Icon(Icons.arrow_drop_down_outlined),
                    onSelected: (int value) {
                      setState(() {
                        ProjectTypeAdd.quack = value;
                        pages.projectType.text = projectTypeBinaryValue(value);
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
                _index3(pages.yearPublished),
              ],
            ),
          ),
          PageViewButtons(
            flabel: "NEXT",
            blabel: 'CANCEL',
            ffunction: () => widget.forward(),
            bfunction: () => _cancel(),
          ),
        ],
      ),
    );
  }
}

Widget _index1(capstoneTitle) {
  return CustomTextField(
    controller: capstoneTitle,
    label: "Capstone Title",
    readOnly: false,
  );
}

Widget _index3(yearPublished) {
  return CustomTextField(
    controller: yearPublished,
    label: "Year Published",
    readOnly: false,
    index: 1,
  );
}
