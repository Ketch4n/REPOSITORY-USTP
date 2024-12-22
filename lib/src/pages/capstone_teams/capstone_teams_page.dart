import 'dart:async';

import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/duck_404.dart';
import 'package:repository_ustp/src/data/provider/card_click_event.dart';
import 'package:repository_ustp/src/data/provider/click_event_keyword.dart';
import 'package:repository_ustp/src/pages/capstone_teams/authors_function.dart';
import 'package:repository_ustp/src/pages/capstone_teams/authors_model.dart';

class CapstoneTeamsPage extends StatefulWidget {
  const CapstoneTeamsPage({super.key});

  @override
  State<CapstoneTeamsPage> createState() => _CapstoneTeamsPageState();
}

class _CapstoneTeamsPageState extends State<CapstoneTeamsPage> {
  final StreamController<List<AuthorsModel>> _teamStream =
      StreamController<List<AuthorsModel>>();

  @override
  void initState() {
    super.initState();
    reload();
  }

  @override
  dispose() {
    super.dispose();
    _teamStream.close();
  }

  void reload() {
    AuthorsFunction.fetchAuthors(_teamStream);
  }

  void clear() {
    setState(() {
      CLickEventProjectType.quack = 0;
      ClickEventProjectKeyword.quack = 0;
      reload();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("TEAMS NAME / AUTHORS"),
            IconButton(
              onPressed: () {
                clear();
              },
              icon: const Icon(
                Icons.refresh,
                color: Colors.blue,
              ),
            )
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Align(
          alignment: Alignment.center,
          child: StreamBuilder<List<AuthorsModel>>(
              stream: _teamStream.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<AuthorsModel?> teamlist = snapshot.data!;

                  if (teamlist.isEmpty) {
                    return const Duck(status: "NO GROUPS YET", content: "");
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
        ),
      ),
    );
  }
}

_buildContent(index, teamList) {
  final AuthorsModel team = teamList[index];
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
      title: Text(
        team.group_name,
        style: const TextStyle(fontSize: 18),
      ),
      trailing: Text(
        "${team.title} - ${team.year_published}",
        style: const TextStyle(fontSize: 18),
      ),
      children: List.generate(
        team.authors.where((author) => author != null).length,
        (index) => _buildExpandedContent(
            index, team.authors.where((author) => author != null).toList()),
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
    title: Text(team ?? ""),
  );
}
