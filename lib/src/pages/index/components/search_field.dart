import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/textfield.dart';
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
  // final TextEditingController _searchController = TextEditingController();
  // final TextEditingController _allController = TextEditingController();
  // final TextEditingController _keywordController = TextEditingController();
  // final TextEditingController _filesController = TextEditingController();

  final _searchController = SearchFieldController().search;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Wrap(
          spacing: 10.0,
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          children: [
            SizedBox(
              width: 200,
              child: CustomTextField(
                controller: _searchController,
                hint: "SEARCH",
                readOnly: false,
                suffix: IconButton(
                    onPressed: () {
                      widget.reload();
                    },
                    icon: const Icon(Icons.search)),
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
