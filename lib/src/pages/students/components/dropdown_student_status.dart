import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/confirmation_dialog.dart';
import 'package:repository_ustp/src/pages/students/students_function.dart';

class DropdownStudentStatus extends StatefulWidget {
  const DropdownStudentStatus(
      {super.key,
      required this.id,
      required this.status,
      required this.reload});
  final int id;
  final int status;
  final Function reload;

  @override
  State<DropdownStudentStatus> createState() => _DropdownStudentStatusState();
}

class _DropdownStudentStatusState extends State<DropdownStudentStatus> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      onSelected: (value) async {
        switch (value) {
          case 1:
            // Archive action
            const title = "Archive this User ?";
            const content = "Admin Access Required";
            confirmationDialog(context, title, content, () {
              StudentFunctions.archiveStudent(context, widget.id, widget.status)
                  .then((value) => widget.reload());
            });
            break;
          case 2:
            // Delete action
            const title = "Delete this User ?";
            const content = "Admin Access Required";
            confirmationDialog(context, title, content, () {
              StudentFunctions.deleteStudent(context, widget.id.toInt())
                  .then((value) => widget.reload());
            });
            break;
        }
        widget.reload(); // Call the reload function passed from parent
      },
      icon: const Icon(Icons.menu),
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem<int>(
          value: 1,
          child: Text('Archive'),
        ),
        const PopupMenuItem<int>(
          value: 2,
          child: Text('Delete'),
        ),
      ],
    );
  }
}
