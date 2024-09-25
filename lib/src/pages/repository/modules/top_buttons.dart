import 'package:flutter/material.dart';
import 'package:repository_ustp/src/pages/repository/components/repository_add.dart';

class RepositoryTopButtons extends StatefulWidget {
  const RepositoryTopButtons(
      {super.key, required this.reload, required this.toPDF});
  final Function reload;
  final Function toPDF;

  @override
  State<RepositoryTopButtons> createState() => _RepositoryTopButtonsState();
}

class _RepositoryTopButtonsState extends State<RepositoryTopButtons> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MaterialButton(
            color: Colors.green,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      RepositoryAdd(reload: () => widget.reload)));
            },
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Add New Project",
                  style: TextStyle(color: Colors.white),
                ),
                Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          MaterialButton(
            color: Colors.grey,
            onPressed: () {
              widget.toPDF();
            },
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Report",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.picture_as_pdf,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
