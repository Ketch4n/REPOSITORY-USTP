import 'package:flutter/material.dart';
import 'package:repository_ustp/src/pages/projects/project_model.dart';

class RepositoryUpdate extends StatefulWidget {
  const RepositoryUpdate({
    super.key,
    required this.reload,
    required this.instance,
  });
  final Function reload;
  final ProjectModel instance;

  @override
  State<RepositoryUpdate> createState() => _RepositoryUpdateState();
}

class _RepositoryUpdateState extends State<RepositoryUpdate> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
