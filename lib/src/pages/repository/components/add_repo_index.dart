import 'package:flutter/material.dart';
import 'package:repository_ustp/src/pages/repository/components/repository_add.dart';
import 'package:repository_ustp/src/pages/repository/components/repository_confirm.dart';

class AddRepoIndex extends StatefulWidget {
  const AddRepoIndex({super.key});

  @override
  State<AddRepoIndex> createState() => _AddRepoIndexState();
}

class _AddRepoIndexState extends State<AddRepoIndex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(child: RepositoryAdd(reload: () {})),
          const Expanded(child: RepositoryConfirm())
        ],
      ),
    );
  }
}
