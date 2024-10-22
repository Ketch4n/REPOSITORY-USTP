import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/loading.dart';
import 'package:repository_ustp/src/components/snackbar.dart';
import 'package:repository_ustp/src/data/index/project_index_value.dart';
import 'package:repository_ustp/src/data/mail/sendmail.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/class/access_controller_instance.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/class/clear_controllers.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/functions/upload_files.dart';
import 'package:repository_ustp/src/pages/repository/repository_function.dart';

class ProjectFunction {
  static const link = "https://repository-ustp.firebaseapp.com/";
  var postOutput = {};
  var updateOutput = {};

  static void submit(BuildContext context, int? projectType,
      List<String?> authors, Function reload) async {
    if (pages.capstoneTitle.text.isEmpty ||
        projectType == null ||
        projectType == 0 ||
        pages.yearPublished.text.isEmpty ||
        pages.groupName.text.isEmpty) {
      customSnackBar(context, 1, "Cannot add empty fields");
      return;
    }
    circularLoading(context);
    try {
      var postOutput = await RepositoryFunction.postProject(
        context,
        pages.capstoneTitle.text,
        projectType,
        pages.yearPublished.text,
        pages.groupName.text,
        authors,
        pages.manuscript.text,
        pages.poster.text,
        pages.video.text,
        pages.zip.text,
      );

      if (postOutput['dataID'] != 0) {
        // customSnackBar(context, 0, "Uploading Please wait...");
        await PagesUploadFiles.uploadFile(context, postOutput['dataID']);
        SendMailFunction.sendEmailTypeStatus(
          link,
          pages.capstoneTitle.text,
          projectTypeBinaryValue(projectType),
          pages.yearPublished.text,
        );
        customSnackBar(context, 0, postOutput['message']);
      } else {
        customSnackBar(context, 1, postOutput['message']);
      }
    } catch (e) {
      print("Submission Error: $e");
    } finally {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      reload();

      ClearTextEditingControllers.clear();
    }
  }

  static update(BuildContext context, int? projectType, List<String?> authors,
      Function reload, int id) async {
    // Input validation
    if (pages.capstoneTitle.text.isEmpty ||
        projectType == null ||
        projectType == 0 ||
        pages.yearPublished.text.isEmpty ||
        pages.groupName.text.isEmpty) {
      customSnackBar(context, 1, "Cannot add empty fields");
      return;
    }
    circularLoading(context);
    try {
      var updateOutput = await RepositoryFunction.updateProject(
        context,
        id,
        pages.capstoneTitle.text,
        projectType,
        pages.yearPublished.text,
        pages.groupName.text,
        authors,
      );

      if (updateOutput['quack']) {
        customSnackBar(context, 0, updateOutput['message']);
      } else {
        customSnackBar(context, 1, updateOutput['message']);
      }
    } catch (e) {
      print("Submission Error: $e");
    } finally {
      Navigator.of(context).pop();
      Navigator.of(context).pop();

      reload();
      ClearTextEditingControllers.clear();
    }
  }
}
