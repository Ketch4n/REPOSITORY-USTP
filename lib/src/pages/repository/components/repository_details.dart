import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repository_ustp/src/data/index/project_index_value.dart';
import 'package:repository_ustp/src/data/provider/project_id.dart';
import 'package:repository_ustp/src/pages/projects/components/text_content.dart';

class RepositoryDetails extends StatefulWidget {
  const RepositoryDetails({super.key});

  @override
  State<RepositoryDetails> createState() => _RepositoryDetailsState();
}

class _RepositoryDetailsState extends State<RepositoryDetails> {
  @override
  Widget build(BuildContext context) {
    final project = Provider.of<ProjectIDClickEvent>(context).selectedProject;
    if (project == null) {
      return const Center(child: Text('No project selected.'));
    }
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: SizedBox(
              height: 190,
              width: 140,
              child: Stack(
                children: [
                  Image.asset("assets/hardbound.png"),
                  TextContent(
                    alignment: Alignment.topCenter,
                    title:
                        "${projectTypeBinaryValue(project.project_type).toString()}\n${project.year_published}",
                    size: 10,
                  ),
                  TextContent(
                    alignment: Alignment.center,
                    title: project.title,
                    color: Colors.yellow,
                  ),
                  TextContent(
                    title: project.group_name,
                    size: 8,
                    alignment: Alignment.bottomCenter,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
