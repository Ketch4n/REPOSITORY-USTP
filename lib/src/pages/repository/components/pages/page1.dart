import 'package:flutter/material.dart';
import 'package:repository_ustp/src/auth/login/modules/add_title.dart';
import 'package:repository_ustp/src/components/textfield.dart';
import 'package:repository_ustp/src/data/index/project_index_value.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  final TextEditingController _capstoneTitleController =
      TextEditingController();
  final TextEditingController _projectTypeController = TextEditingController();
  final TextEditingController _yearPublishedController =
      TextEditingController();

  int? _selectedItem;

  final List<int> _items = [1, 2, 3];

  @override
  void dispose() {
    // Dispose of all the controllers here
    _capstoneTitleController.dispose();
    _projectTypeController.dispose();
    _yearPublishedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        addTitle("ADD NEW REPOSITORY", 20),

        CustomTextField(
          controller: _capstoneTitleController,
          label: "Capstone Title",
        ),
        const SizedBox(height: 10),
        CustomTextField(
          controller: _projectTypeController,
          label: "Project Type",
          suffix: PopupMenuButton<int>(
            icon: const Icon(Icons.menu),
            onSelected: (int value) {
              setState(() {
                _selectedItem = value;
                _projectTypeController.text = projectTypeBinaryValue(value);
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
          controller: _yearPublishedController,
          label: "Year Published",
        ),
      ],
    );
  }
}
