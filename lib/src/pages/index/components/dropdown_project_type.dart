import 'package:flutter/material.dart';
import 'package:repository_ustp/src/data/index/project_index_value.dart';
import 'package:repository_ustp/src/data/provider/card_click_event.dart';

class DropdownProjectType extends StatefulWidget {
  const DropdownProjectType({super.key, required this.reload});
  final Function reload;

  @override
  State<DropdownProjectType> createState() => _DropdownProjectTypeState();
}

class _DropdownProjectTypeState extends State<DropdownProjectType> {
  int? _selectedItem;

  final List<int> _items = [0, 1, 2, 3];
  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: _selectedItem,
      hint: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Text('PROJECT TYPE'),
      ),
      // icon: Icon(Icons.arrow_downward),
      // iconSize: 24,
      // elevation: 16,
      underline: const SizedBox.shrink(),
      // style: TextStyle(color: Colors.deepPurple),
      // underline: Container(
      //   height: 2,
      //   // color: Colors.deepPurpleAccent,
      // ),
      onChanged: (int? newValue) {
        setState(() {
          _selectedItem = newValue;
          CLickEventProjectType.quack = _selectedItem!;
          // widget.reload();
        });
      },
      items: _items.map<DropdownMenuItem<int>>((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text(projectTypeBinaryValue(value)),
        );
      }).toList(),
    );
  }
}
