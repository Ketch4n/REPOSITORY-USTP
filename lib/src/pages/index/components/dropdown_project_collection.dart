import 'package:flutter/material.dart';
import 'package:repository_ustp/src/data/index/project_collection_value.dart';
import 'package:repository_ustp/src/data/provider/click_event_collection.dart';

class DropdownProjectCollection extends StatefulWidget {
  const DropdownProjectCollection({super.key, required this.reload});
  final Function reload;

  @override
  State<DropdownProjectCollection> createState() =>
      _DropdownProjectCollectionState();
}

class _DropdownProjectCollectionState extends State<DropdownProjectCollection> {
  int? _selectedCollection;

  final List<int> _collection = [0, 1, 2, 3];
  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: _selectedCollection,
      hint: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Text('COLLECTION'),
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
          _selectedCollection = newValue;
          ClickEventProjectCollection.quack = _selectedCollection!;
          // widget.reload();
        });
      },
      items: _collection.map<DropdownMenuItem<int>>((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text(projectCollectionBinaryValue(value)),
        );
      }).toList(),
    );
  }
}
