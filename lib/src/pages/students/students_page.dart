import 'dart:async';

import 'package:flutter/material.dart';
import 'package:repository_ustp/src/model/user_model.dart';
import 'package:repository_ustp/src/pages/students/students_function.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key});

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  final StreamController<List<UserModel>> _userStream =
      StreamController<List<UserModel>>();

  @override
  void initState() {
    super.initState();
    StudentFunctions.fetchStudentsList(_userStream, 2);
  }

  @override
  dispose() {
    super.dispose();
    _userStream.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          StreamBuilder<List<UserModel>>(
              stream: _userStream.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<UserModel?> userlist = snapshot.data!;

                  if (userlist.isEmpty) {
                    return const Center(child: Text('No Students Found'));
                  }

                  return Column(
                    children: List.generate(
                        userlist.length, (index) => _buidText(index, userlist)),
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
        ],
      ),
    );
  }
}

_buidText(index, userlist) {
  final UserModel user = userlist[index];
  return Text(user.email);
}
