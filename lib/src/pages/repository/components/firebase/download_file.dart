import 'package:firebase_storage/firebase_storage.dart';

Future<void> downloadFile(String fileName) async {
  final storageRef = FirebaseStorage.instance.ref().child('uploads/$fileName');
  try {
    final url = await storageRef.getDownloadURL();
    print('Download URL: $url');
    // You can use the URL to download the file or display it
  } catch (e) {
    print('Error downloading file: $e');
  }
}
