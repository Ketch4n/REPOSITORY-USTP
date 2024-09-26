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

  static Future<void> selectImg(context) async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      selectedImg = result.files.first;

      final fileExtension = selectedImg!.extension?.toLowerCase();
      if (['jpg', 'jpeg', 'png', 'gif'].contains(fileExtension)) {
        customSnackBar(context, 0, "Added");
        pages.poster.text = selectedImg!.name;
      } else {
        customSnackBar(context, 1, "Invalid Image format");
        pages.poster.clear();
      }
    }
  }

  static Future<void> selectDoc(context) async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      selectedDoc = result.files.first;

      final fileExtension = selectedDoc!.extension?.toLowerCase();
      if (['docx', 'pdf'].contains(fileExtension)) {
        customSnackBar(context, 0, "Added");
        pages.manuscript.text = selectedDoc!.name;
      } else {
        customSnackBar(context, 1, "Invalid Document format");
        pages.manuscript.clear();
      }
    }
  }

  static Future<void> selectClip(context) async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      selectedClip = result.files.first;

      final fileExtension = selectedClip!.extension?.toLowerCase();
      if (['mp4'].contains(fileExtension)) {
        customSnackBar(context, 0, "Added");
        pages.video.text = selectedClip!.name;
      } else {
        customSnackBar(context, 1, "Invalid Video Clip format");
        pages.video.clear();
      }
    }
  }

  static uploadFile(BuildContext context, int outputID) async {
    // Check if _selectedDoc is not null and has bytes
    if (selectedDoc != null && selectedDoc!.bytes != null) {
      final Uint8List fileBytesDoc = selectedDoc!.bytes!;
      final fileNameDoc = selectedDoc!.name;
      final docStorageRef = FirebaseStorage.instance
          .ref()
          .child('repository/$outputID/$fileNameDoc');

      try {
        // Upload document file bytes
        await docStorageRef.putData(fileBytesDoc);
        customSnackBar(context, 0, "Document uploaded successfully");
      } catch (e) {
        print('Error uploading document: $e');
        customSnackBar(context, 1, "Error uploading document");
      }
    } else {
      customSnackBar(context, 1, "No document selected for upload");
    }

    // Check if _selectedImg is not null and has bytes
    if (selectedImg != null && selectedImg!.bytes != null) {
      final Uint8List fileBytesImg = selectedImg!.bytes!;
      final fileNameImg = selectedImg!.name;
      final imgStorageRef = FirebaseStorage.instance
          .ref()
          .child('repository/$outputID/$fileNameImg');

      try {
        // Upload image file bytes
        await imgStorageRef.putData(fileBytesImg);
        customSnackBar(context, 0, "Image uploaded successfully");
      } catch (e) {
        print('Error uploading image: $e');
        customSnackBar(context, 1, "Error uploading image");
      }
    } else {
      customSnackBar(context, 1, "No image selected for upload");
    }

    // Check if _selectedClip is not null and has bytes
    if (selectedClip != null && selectedClip!.bytes != null) {
      final Uint8List fileBytesClip = selectedClip!.bytes!;
      final fileNameClip = selectedClip!.name;
      final clipStorageRef = FirebaseStorage.instance
          .ref()
          .child('repository/$outputID/$fileNameClip');

      try {
        // Upload video clip file bytes
        await clipStorageRef.putData(fileBytesClip);
        customSnackBar(context, 0, "Video uploaded successfully");
      } catch (e) {
        print('Error uploading video: $e');
        customSnackBar(context, 1, "Error uploading video");
      }
    } else {
      customSnackBar(context, 1, "No video clip selected for upload");
    }
  }
}
