import 'package:flutter/material.dart';
import 'package:repository_ustp/src/data/instance/instance.dart';

class InstanceTextEditing {
  // Singleton pattern to ensure a single instance
  static final InstanceTextEditing _instance = InstanceTextEditing._internal();

  factory InstanceTextEditing() => _instance;

  InstanceTextEditing._internal();

  // Publicly accessible TextEditingController
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  // Dispose method to clean up resources
  void dispose() {
    email.dispose();
    pass.dispose();
  }

  static void clear() {
    controller.email.clear();
    controller.pass.clear();
  }
}
