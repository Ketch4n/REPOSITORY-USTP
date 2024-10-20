import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repository_ustp/src/auth/login/modules/add_title.dart';
import 'package:repository_ustp/src/data/provider/project_purpose.dart';

class PagesTitle extends StatelessWidget {
  const PagesTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectPurpose>(builder: (context, value, child) {
      return addTitle(
          value.quackNew == 0 ? "ADD NEW PROJECT" : "UPDATE PROJECT", 20, null);
    });
  }
}
