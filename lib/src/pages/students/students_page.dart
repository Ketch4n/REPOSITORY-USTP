import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:repository_ustp/src/components/duck_404.dart';
import 'package:repository_ustp/src/components/snackbar.dart';
import 'package:repository_ustp/src/data/provider/user_session.dart';
import 'package:repository_ustp/src/model/user_model.dart';
import 'package:repository_ustp/src/pages/students/components/dropdown_student_status.dart';
import 'package:repository_ustp/src/pages/students/students_function.dart';
import 'package:pdf/widgets.dart' as pw;

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key, required this.type, required this.status});
  final int type;
  final int status;

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

// const int selectedValue = 0;

class _StudentsPageState extends State<StudentsPage> {
  final StreamController<List<UserModel>> _userStream =
      StreamController<List<UserModel>>();
  List<UserModel?> users = [];
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

  Future<void> exportToPDF() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text(
                'Active Users',
                style:
                    pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
                textAlign: pw.TextAlign.center,
              ),
              pw.SizedBox(height: 20),
              pw.TableHelper.fromTextArray(
                headers: [
                  'Username',
                  'Email',
                ],
                data: users.map((user) {
                  return [
                    user!.username,
                    user.email,
                  ];
                }).toList(),
              ),
            ],
          );
        },
      ),
    );
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.status == 1 ? "ACTIVE STUDENTS" : "ARCHIVED STUDENTS"),
            IconButton(
                onPressed: () {
                  reload();
                },
                icon: const Icon(
                  Icons.refresh,
                  color: Colors.blue,
                ))
          ],
        ),
        actions: [
          MaterialButton(
            color: Colors.grey,
            onPressed: () {
              if (UserSession.type == 0 || UserSession.type == 1) {
                exportToPDF();
              } else {
                customSnackBar(context, 1, "Administrator Access Only");
              }
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
          const SizedBox(width: 20),
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
                      users = userlist;

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
              status: 2,
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
          : DropdownStudentStatus(
              id: user.id,
              status: 1,
              reload: reload,
            ),
    ),
  );
}
