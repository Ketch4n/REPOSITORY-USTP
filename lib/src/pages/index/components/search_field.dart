import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/textfield.dart';
import 'package:repository_ustp/src/data/index/project_index_value.dart';
import 'package:repository_ustp/src/data/provider/card_click_event.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final TextEditingController _searchController = TextEditingController();
  // final TextEditingController _allController = TextEditingController();
  // final TextEditingController _keywordController = TextEditingController();
  // final TextEditingController _filesController = TextEditingController();

  int? _selectedItem;

  final List<int> _items = [1, 2, 3];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Wrap(
          runSpacing: 10.0,
          spacing: 10.0,
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          children: [
            SizedBox(
              width: 200,
              child: CustomTextField(
                controller: _searchController,
                hint: "SEARCH",
              ),
            ),
            Container(
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: DropdownButton<int>(
                value: _selectedItem,
                hint: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('ALL'),
                ),
                // icon: Icon(Icons.arrow_downward),
                // iconSize: 24,
                elevation: 16,
                underline: const SizedBox.shrink(),
                // style: TextStyle(color: Colors.deepPurple),
                // underline: Container(
                //   height: 2,
                //   // color: Colors.deepPurpleAccent,
                // ),
                onChanged: (int? newValue) {
                  setState(() {
                    _selectedItem = newValue;
                    CardClickEvent.quack = _selectedItem!;
                  });
                },
                items: _items.map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(projectTypeBinaryValue(value)),
                  );
                }).toList(),
              ),
            ),
            // CustomTextField(
            //   controller: _allController,
            //   hint: "ALL",
            // ),
            // CustomTextField(
            //   controller: _keywordController,
            //   hint: "KEYWORD",
            // ),
            // CustomTextField(
            //   controller: _filesController,
            //   hint: "FILES",
            // ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
