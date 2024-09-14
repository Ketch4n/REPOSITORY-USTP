import 'dart:async';
import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/duck_404.dart';
import 'package:repository_ustp/src/model/user_model.dart';
import 'package:repository_ustp/src/pages/students/components/dropdown_student_status.dart';
import 'package:repository_ustp/src/pages/students/students_function.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key, required this.type, required this.status});
  final int type;
  final int status;

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

const int _selectedValue = 0;

class _StudentsPageState extends State<StudentsPage> {
  final StreamController<List<UserModel>> _userStream =
      StreamController<List<UserModel>>();

  void reload() {
    StudentFunctions.fetchStudentsList(_userStream, widget.type, widget.status);
  }

  @override
  void initState() {
    super.initState();
    StudentFunctions.fetchStudentsList(_userStream, widget.type, widget.status);
  }

  @override
  dispose() {
    super.dispose();
    _userStream.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.status == 1 ? "ACTIVE STUDENTS" : "ARCHIVED STUDENTS"),
        actions: [
          IconButton(
              onPressed: () {
                reload();
              },
              icon: const Icon(Icons.refresh))
        ],
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: StreamBuilder<List<UserModel>>(
                  stream: _userStream.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List<UserModel?> userlist = snapshot.data!;

                      if (userlist.isEmpty) {
                        return const Duck(
                            status: "NO STUDENT USERS YET", content: "");
                      }

                      return Column(
                        children: List.generate(
                            userlist.length,
                            (index) => _buidText(
                                index, userlist, widget.status, reload)),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("Error: ${snapshot.error}"),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

_buidText(index, userlist, status, reload) {
  final UserModel user = userlist[index];
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Image.asset(
          "assets/user.png",
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(user.username),
      subtitle: Text(user.email),
      trailing: status == 1
          ? DropdownStudentStatus(
              id: user.id,
              status: status == 1 ? 2 : status,
              reload: reload,
            )
          // Row(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       const Text("Access"),
          //       Radio<int>(
          //         value: 0,
          //         groupValue: _selectedValue,
          //         onChanged: null,
          //         fillColor: MaterialStateProperty.all(Colors.blue),
          //       ),
          //       const Text("Public"),
          //       const SizedBox(width: 8),
          //       Radio<int>(
          //         value: 1,
          //         groupValue: _selectedValue,
          //         onChanged: null,
          //         fillColor: MaterialStateProperty.all(Colors.orange),
          //       ),
          //       const Text("Private"),
          //       const SizedBox(width: 8),
          //       Radio<int>(
          //         value: 1,
          //         groupValue: _selectedValue,
          //         onChanged: null,
          //         fillColor: MaterialStateProperty.all(Colors.green),
          //       ),
          //       const Text("Shared"),
          //     ],
          //   )
          : const Text("No email notification and access to Repository"),
    ),
  );
}
