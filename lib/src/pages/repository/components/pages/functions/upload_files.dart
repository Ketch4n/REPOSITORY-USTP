import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/snackbar.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/class/text_editing_controller.dart';

class PagesUploadFiles {
  static final pages = PagesTextEditingController();
  static PlatformFile? selectedImg;
  static PlatformFile? selectedDoc;
  static PlatformFile? selectedClip;
  static PlatformFile? selectedZip;

  static Future<void> selectImg(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      selectedImg = result.files.first;
      final fileExtension = selectedImg!.extension?.toLowerCase();
      if (['jpg', 'jpeg', 'png', 'gif'].contains(fileExtension)) {
        pages.poster.text = selectedImg!.name;
      } else {
        if (!context.mounted) return;
        customSnackBar(context, 1, "Invalid Image format");
        selectedImg = null;
      }
    }
  }

  static Future<void> selectDoc(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      selectedDoc = result.files.first;

      final fileExtension = selectedDoc!.extension?.toLowerCase();
      if (['jpg', 'jpeg', 'png', 'gif', 'mp4'].contains(fileExtension)) {
        if (!context.mounted) return;
        customSnackBar(context, 1, "Invalid Document format");
        selectedDoc = null;
      } else {
        pages.manuscript.text = selectedDoc!.name;
      }
    }
  }

  static Future<void> selectClip(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      selectedClip = result.files.first;

      final fileExtension = selectedClip!.extension?.toLowerCase();
      if (['mp4'].contains(fileExtension)) {
        pages.video.text = selectedClip!.name;
      } else {
        if (!context.mounted) return;
        customSnackBar(context, 1, "Invalid Video Clip format");
        selectedClip = null;
      }
    }
  }

  static Future<void> selectZip(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      selectedZip = result.files.first;

      final fileExtension = selectedZip!.extension?.toLowerCase();
      if (['zip'].contains(fileExtension)) {
        pages.zip.text = selectedZip!.name;
      } else {
        if (!context.mounted) return;
        customSnackBar(context, 1, "Invalid source code format");
        selectedZip = null;
      }
    }
  }

  static String getContentType(String? extension) {
    switch (extension?.toLowerCase()) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'pdf':
        return 'application/pdf';
      case 'docx':
        return 'application/docx';
      case 'mp4':
        return 'video/mp4';
      case 'zip':
        return 'zip';
      default:
        return 'application/octet-stream';
    }
  }

  static Future<void> uploadFile(BuildContext context, int outputID) async {
    Future<void> uploadFileToFirebase(
        PlatformFile? file, String fileType) async {
      if (file != null) {
        final fileName = file.name;
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('repository/$outputID/$fileName');

        try {
          if (kIsWeb) {
            await storageRef.putData(file.bytes!,
                SettableMetadata(contentType: getContentType(file.extension)));
          } else {
            await storageRef.putFile(File(file.path!),
                SettableMetadata(contentType: getContentType(file.extension)));
          }
          customSnackBar(context, 1, "$fileType Upload Done");
        } catch (e) {
          print('Error uploading $fileType: $e');
        } finally {
          // Clear the selected file after upload
          if (fileType == "document")
            selectedDoc = null;
          else if (fileType == "image")
            selectedImg = null;
          else if (fileType == "video")
            selectedClip = null;
          else if (fileType == "zip") selectedZip = null;
        }
      } else {
        customSnackBar(context, 1, "No $fileType selected for upload");
      }
    }

    await uploadFileToFirebase(selectedDoc, "document");
    await uploadFileToFirebase(selectedImg, "image");
    await uploadFileToFirebase(selectedClip, "video");
    await uploadFileToFirebase(selectedZip, "source code");
  }
}
