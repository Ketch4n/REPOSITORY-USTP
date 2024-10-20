import 'package:flutter/material.dart';
import 'package:repository_ustp/src/data/provider/search_suggestion.dart';
import 'package:repository_ustp/src/pages/index/components/dropdown_project_collection.dart';
import 'package:repository_ustp/src/pages/index/components/dropdown_project_keyword.dart';
import 'package:repository_ustp/src/pages/index/components/dropdown_project_type.dart';
import 'package:repository_ustp/src/pages/index/components/search_field_controller.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key, required this.reload});
  final Function reload;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final _searchController = SearchFieldController().search;
  List<String> _suggestions = [];

  void _updateSuggestions(String query) {
    if (query.isEmpty) {
      setState(() {
        _suggestions = [];
      });
    } else {
      setState(() {
        _suggestions = SearchSuggestion.allItems
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          children: [
            SizedBox(
              width: 200,
              child: Column(
                children: [
                  TextField(
                    onChanged: _updateSuggestions,
                    controller: _searchController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      isDense: true,
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      hintText: "SEARCH",
                      hintStyle: const TextStyle(fontSize: 15),
                      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: IconButton(
                        onPressed: () {
                          widget.reload();
                        },
                        icon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                  if (_suggestions.isNotEmpty) ...[
                    Container(
                      height: 100,
                      color: Colors.white,
                      child: ListView.builder(
                        itemCount: _suggestions.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(_suggestions[index]),
                            onTap: () {
                              _searchController.text = _suggestions[index];
                              setState(() {
                                _suggestions = [];
                              });
                              widget.reload();
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Container(
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: DropdownProjectType(reload: widget.reload),
            ),
            Container(
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: DropdownProjectKeyword(reload: widget.reload),
            ),
            Container(
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: DropdownProjectCollection(reload: widget.reload),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: IconButton(
                onPressed: () {
                  widget.reload();
                },
                icon: const Icon(Icons.search),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
