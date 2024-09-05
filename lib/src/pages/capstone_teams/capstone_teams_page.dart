import 'dart:async';

import 'package:flutter/material.dart';
import 'package:repository_ustp/src/data/session.dart';
import 'package:repository_ustp/src/pages/projects/project_function.dart';
import 'package:repository_ustp/src/pages/projects/project_model.dart';

class CapstoneTeamsPage extends StatefulWidget {
  const CapstoneTeamsPage({super.key});

  @override
  State<CapstoneTeamsPage> createState() => _CapstoneTeamsPageState();
}

class _CapstoneTeamsPageState extends State<CapstoneTeamsPage> {
  final StreamController<List<ProjectModel>> _teamStream =
      StreamController<List<ProjectModel>>();

  @override
  void initState() {
    super.initState();
    ProjectFunction.fetchProjects(_teamStream, CardTypeClick.quack);
  }

  @override
  dispose() {
    super.dispose();
    _teamStream.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CAPSTONE TEAMS / AUTHORS"),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<List<ProjectModel>>(
                stream: _teamStream.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<ProjectModel?> teamlist = snapshot.data!;

                    if (teamlist.isEmpty) {
                      return const Center(child: Text('No Team Found'));
                    }

                    return Column(
                      children: List.generate(teamlist.length,
                          (index) => _buildContent(index, teamlist)),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Error: ${snapshot.error}"),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}

_buildContent(index, teamList) {
  final ProjectModel team = teamList[index];
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: ExpansionTile(
      // childrenPadding: EdgeInsets.all(),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Image.asset(
          "assets/ustp_v2.png",
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(team.group_name),
      trailing: Text("${team.title} - ${team.year_published}"),
      children: List.generate(
        team.author.length,
        (index) => _buildExpandedContent(index, team.author),
      ),

      // ListTile(
      //   title: Text('Expanded content 1'),
      // ),
      // ListTile(
      //   title: Text('Expanded content 2'),
      // ),
    ),
  );
}

_buildExpandedContent(index, teamList) {
  final team = teamList[index];
  return ListTile(
    title: Text(team),
  );
}
