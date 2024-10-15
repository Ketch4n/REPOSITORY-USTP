import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:repository_ustp/src/components/duck_404.dart';
import 'package:repository_ustp/src/data/index/project_index_value.dart';
import 'package:repository_ustp/src/data/provider/project_id.dart';
import 'package:repository_ustp/src/pages/projects/components/text_content.dart';
import 'package:repository_ustp/src/pages/repository/components/functions/get_likecomment.dart';
import 'package:repository_ustp/src/pages/repository/components/model/likecomment_model.dart';
import 'package:repository_ustp/src/pages/repository/components/repository_open.dart';

class RepositoryDetails extends StatefulWidget {
  const RepositoryDetails({
    super.key,
    required this.indexPage,
  });
  final Function indexPage;

  @override
  State<RepositoryDetails> createState() => _RepositoryDetailsState();
}

class _RepositoryDetailsState extends State<RepositoryDetails> {
  final StreamController<List<LikecommentModel>> _likecommentStream =
      StreamController<List<LikecommentModel>>();
  // List<LikecommentModel> likecomment = [];
  bool _openEye = false;

  @override
  Widget build(BuildContext context) {
    final project = Provider.of<ProjectIDClickEvent>(context).selectedProject;

    if (project == null) {
      return const Center(child: Text('No project selected.'));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("DETAILS"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              widget.indexPage(0);
            },
            icon: const Icon(Icons.arrow_back_ios_new_sharp)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
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
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const Text("Project Title:      "),
                          Text(
                            project.title.toUpperCase(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Project Type:     "),
                          Text(
                            projectTypeBinaryValue(project.project_type),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Year Published: "),
                          Text(
                            project.year_published.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Group Name:     "),
                          Text(
                            project.group_name.toUpperCase(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: ((context) => RepositoryOpen(
                                      projectID: project.id,
                                    )),
                              ),
                            );
                          },
                          child: const Text("File Details"))
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text("Viewers Comments"),
                      const SizedBox(width: 10),
                      Icon(
                        _openEye ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text("Average Ratings"),
                      RatingBar.builder(
                        ignoreGestures: true,
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemSize: 20.0,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print("Rating: $rating");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<List<LikecommentModel>>(
                stream: _likecommentStream.stream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          getLikeComment(_likecommentStream, project.id);
                          setState(() {
                            _openEye = true;
                          });
                        },
                        child: const Text("Show Comments"),
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Error: ${snapshot.error}"),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Duck(status: "NO COMMENT YET", content: "");
                  }

                  if (snapshot.hasData || snapshot.data!.isNotEmpty) {
                    final List<LikecommentModel> likecommentList =
                        snapshot.data!;

                    return SingleChildScrollView(
                      child: Column(
                        children: List.generate(
                          likecommentList.length,
                          (index) =>
                              _buildBody(index, context, likecommentList),
                        ),
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildBody(index, context, likecommentList) {
  final LikecommentModel likecomment = likecommentList[index];

  return Card(
    child: ListTile(
      leading: const Icon(
        Icons.circle,
        color: Colors.green,
        size: 18,
      ),
      title: Text(likecomment.username),
      subtitle: Text(
        '"${likecomment.comment}"',
        style: const TextStyle(fontStyle: FontStyle.italic),
      ),
      trailing: RatingBar.builder(
        ignoreGestures: true,
        initialRating: likecomment.rating.toDouble(),
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: false,
        itemCount: 5,
        itemSize: 20.0,
        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (rating) {
          // print("Rating: $rating");
        },
      ),
    ),
  );
}
