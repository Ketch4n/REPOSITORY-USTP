import 'package:flutter/material.dart';
import 'package:repository_ustp/src/data/index/project_keyword_value.dart';
import 'package:repository_ustp/src/data/provider/click_event_keyword.dart';

class DropdownProjectKeyword extends StatefulWidget {
  const DropdownProjectKeyword({super.key, required this.reload});
  final Function reload;

  @override
  State<DropdownProjectKeyword> createState() => _DropdownProjectKeywordState();
}

class _DropdownProjectKeywordState extends State<DropdownProjectKeyword> {
  int? _selectedKeyword;

  final List<int> _keywords = [0, 1, 3];
  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: _selectedKeyword,
      hint: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Text('KEYWORD'),
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
          _selectedKeyword = newValue;
          ClickEventProjectKeyword.quack = _selectedKeyword!;
          // widget.reload();
        });
      },
      items: _keywords.map<DropdownMenuItem<int>>((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text(projectKeywordBinaryValue(value)),
        );
      }).toList(),
    );
  }
}
