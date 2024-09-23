import 'package:flutter/material.dart';
import 'package:repository_ustp/src/auth/login/modules/add_title.dart';
import 'package:repository_ustp/src/components/button.dart';
import 'package:repository_ustp/src/components/textbutton.dart';
import 'package:repository_ustp/src/components/textfield.dart';
import 'package:repository_ustp/src/data/index/project_index_value.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/components/text_editing_controller.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key, required this.forward});
  final Function forward;

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  int? _selectedItem;

  final List<int> _items = [1, 2, 3];

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
                  controller: pages.capstoneTitle,
                  label: "Capstone Title",
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: pages.projectType,
                  label: "Project Type",
                  suffix: PopupMenuButton<int>(
                    icon: const Icon(Icons.menu),
                    onSelected: (int value) {
                      setState(() {
                        _selectedItem = value;
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
                // Container(
                //   height: 60,
                //   width: double.maxFinite,
                //   decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(5)),
                //   child: ProjectDropdownCategory(),
                // ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: pages.yearPublished,
                  label: "Year Published",
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
                      text: 'CANCEL',
                      callback: () {
                        Navigator.of(context).pop();
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
