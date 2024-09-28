import 'package:firebase_storage/firebase_storage.dart';

class PagesGetFiles {
  static List<Reference> fileReferences = [];

  static Future<void> getFileRef(id) async {
    final storage = FirebaseStorage.instance;
    final projectID = id;
    final folderName = 'repository/$projectID';

    try {
      final listResult = await storage.ref(folderName).listAll();

      fileReferences = listResult.items;
    } catch (e) {
      print('Error listing files: $e');
    }
  }

  // Delete a single file by its reference
  static Future<void> deleteFile(Reference fileRef) async {
    try {
      await fileRef.delete(); // Delete the file from Firebase Storage
      print('File deleted: ${fileRef.name}');
    } catch (e) {
      print('Error deleting file: $e');
    }
  }

  // Delete all files in the folder (and thus the folder itself)
  static Future<void> deleteFolder(String id) async {
    await getFileRef(id); // Fetch all files in the folder
    try {
      for (var fileRef in fileReferences) {
        await deleteFile(fileRef); // Delete each file in the folder
      }
      print('Folder and its files deleted successfully');
    } catch (e) {
      print('Error deleting files: $e');
    }
  }
}
