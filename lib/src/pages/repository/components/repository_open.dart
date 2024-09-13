import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/duck_404.dart';

class RepositoryOpen extends StatefulWidget {
  const RepositoryOpen({super.key});

  @override
  State<RepositoryOpen> createState() => _RepositoryOpenState();
}

class _RepositoryOpenState extends State<RepositoryOpen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 800,
      // width: 800,
      constraints: const BoxConstraints(maxHeight: 800, maxWidth: 800),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: const Center(
        child: Duck(status: "OPEN", content: "quack quack"),
      ),
    );
  }
}
