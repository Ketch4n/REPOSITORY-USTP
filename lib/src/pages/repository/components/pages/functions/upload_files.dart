// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/snackbar.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/class/text_editing_controller.dart';

class PagesUploadFiles {
  static final pages = PagesTextEditingController();
  static PlatformFile? selectedImg;
  static PlatformFile? selectedDoc;
  static PlatformFile? selectedClip;

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
        // selectedImg == null;
      }
    }
  }

  static Future<void> selectDoc(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      selectedDoc = result.files.first;

      final fileExtension = selectedDoc!.extension?.toLowerCase();
      if (['docx', 'pdf'].contains(fileExtension)) {
        pages.manuscript.text = selectedDoc!.name;
      } else {
        if (!context.mounted) return;
        customSnackBar(context, 1, "Invalid Document format");
        // selectedDoc == null;
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
        // selectedClip == null;
      }
    }
  }

  static Future<void> uploadFile(BuildContext context, int outputID) async {
    if (selectedDoc != null && selectedDoc!.bytes != null) {
      final Uint8List fileBytesDoc = selectedDoc!.bytes!;
      final fileNameDoc = selectedDoc!.name;
      final docStorageRef = FirebaseStorage.instance
          .ref()
          .child('repository/$outputID/$fileNameDoc');

      try {
        await docStorageRef.putData(fileBytesDoc);
      } catch (e) {
        print('Error uploading document: $e');
      }
    } else {
      // customSnackBar(context, 1, "No document selected for upload");
    }

    if (selectedImg != null && selectedImg!.bytes != null) {
      final Uint8List fileBytesImg = selectedImg!.bytes!;
      final fileNameImg = selectedImg!.name;
      final imgStorageRef = FirebaseStorage.instance
          .ref()
          .child('repository/$outputID/$fileNameImg');

      try {
        await imgStorageRef.putData(fileBytesImg);
      } catch (e) {
        print('Error uploading image: $e');
      }
    } else {
      // customSnackBar(context, 1, "No image selected for upload");
    }

    if (selectedClip != null && selectedClip!.bytes != null) {
      final Uint8List fileBytesClip = selectedClip!.bytes!;
      final fileNameClip = selectedClip!.name;
      final clipStorageRef = FirebaseStorage.instance
          .ref()
          .child('repository/$outputID/$fileNameClip');

      try {
        await clipStorageRef.putData(fileBytesClip);
      } catch (e) {
        print('Error uploading video: $e');
      }
    } else {
      // customSnackBar(context, 1, "No video clip selected for upload");
    }
  }
}
