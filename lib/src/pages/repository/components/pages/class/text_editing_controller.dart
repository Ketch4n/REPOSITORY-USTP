// controllers.dart
import 'package:flutter/material.dart';

class PagesTextEditingController {
  // Singleton pattern to ensure a single instance
  static final PagesTextEditingController _instance =
      PagesTextEditingController._internal();

  factory PagesTextEditingController() => _instance;

  PagesTextEditingController._internal();

  // Publicly accessible TextEditingController
  TextEditingController capstoneTitle = TextEditingController();
  TextEditingController projectType = TextEditingController();
  TextEditingController yearPublished = TextEditingController();
  TextEditingController groupName = TextEditingController();
  TextEditingController authors = TextEditingController();

  TextEditingController manuscript = TextEditingController();
  TextEditingController poster = TextEditingController();
  TextEditingController video = TextEditingController();

  // Dispose method to clean up resources
  void dispose() {
    capstoneTitle.dispose();
    projectType.dispose();
    yearPublished.dispose();
    groupName.dispose();
    authors.dispose();

    manuscript.dispose();
    poster.dispose();
    video.dispose();
  }
}
