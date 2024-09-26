import 'package:firebase_storage/firebase_storage.dart';

class PagesGetFiles {
  static List<Reference> fileReferences = [];

  static Future<void> getFileRef(id) async {
    final storage = FirebaseStorage.instance;
    final projectID = id;
    final folderName = 'repository/$projectID';

    try {
      final listResult = await storage.ref(folderName).list();

      fileReferences = listResult.items;
    } catch (e) {
      print('Error listing files: $e');
    }
  }
}
