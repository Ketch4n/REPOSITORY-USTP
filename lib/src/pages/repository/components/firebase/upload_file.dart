import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

Future<void> uploadFile() async {
  final result = await FilePicker.platform.pickFiles();
  if (result == null) return;

  final file = File(result.files.single.path!);
  final fileName = result.files.single.name;

  try {
    final storageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    await storageRef.putFile(file);
    print('File uploaded successfully');
  } catch (e) {
    print('Error uploading file: $e');
  }
}
