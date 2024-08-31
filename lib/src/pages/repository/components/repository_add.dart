import 'package:flutter/material.dart';
import 'package:repository_ustp/src/utils/palette.dart';

class RepositoryAdd extends StatefulWidget {
  const RepositoryAdd({super.key});

  @override
  State<RepositoryAdd> createState() => _RepositoryAddState();
}

class _RepositoryAddState extends State<RepositoryAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                height: 470,
                width: 450,
                decoration: BoxDecoration(
                  color: ColorPallete.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(child: Text("Quack")))));
  }
}
