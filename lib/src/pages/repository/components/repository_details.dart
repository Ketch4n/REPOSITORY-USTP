import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:repository_ustp/src/components/confirmation_dialog.dart';
import 'package:repository_ustp/src/components/show_dialog.dart';
import 'package:repository_ustp/src/data/index/project_index_value.dart';
import 'package:repository_ustp/src/data/index/project_semester.dart';
import 'package:repository_ustp/src/data/provider/project_id.dart';
import 'package:repository_ustp/src/data/provider/user_session.dart';
import 'package:repository_ustp/src/pages/projects/components/text_content.dart';
import 'package:repository_ustp/src/pages/repository/components/functions/delete_ratingcomment.dart';
import 'package:repository_ustp/src/pages/repository/components/functions/get_likecomment.dart';
import 'package:repository_ustp/src/pages/repository/components/model/likecomment_model.dart';
import 'package:repository_ustp/src/pages/repository/components/ratingcomment_update.dart';
import 'package:repository_ustp/src/pages/repository/components/repository_open.dart';
import 'package:repository_ustp/src/pages/repository/components/repository_ratings_add.dart';
import 'package:repository_ustp/src/utils/palette.dart';

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
  fetchLikeComment(id) {
    getLikeComment(_likecommentStream, id);
  }

  @override
  Widget build(BuildContext context) {
    final project = Provider.of<ProjectIDClickEvent>(context).selectedProject;

    if (project == null) {
      return const Center(child: Text('No project selected.'));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "DETAILS",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: ColorPallete.skyblueLite,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              widget.indexPage(0);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_sharp,
              color: Colors.white,
            )),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
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
                          const Text("Project Title: ------ "),
                          Text(
                            project.title.toUpperCase(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Project Type: ----- "),
                          Text(
                            projectTypeBinaryValue(project.project_type),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Year Published: -- "),
                          Text(
                            "${project.year_published} ${project.semester == 4 ? "" : projectSemesterBinaryValue(project.semester)}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Group Name: ----- "),
                          Text(
                            project.group_name.toUpperCase(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Authors: ----------- "),
                          Text(
                            project.authors
                                .where((author) => author != null)
                                .join(', ')
                                .toUpperCase(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      MaterialButton(
                          color: Colors.blue,
                          onPressed: () {
                            showCustomDialog(
                              context,
                              RepositoryOpen(
                                projectID: project.id,
                              ),
                            );
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: ((context) => RepositoryOpen(
                            //           projectID: project.id,
                            //         )),
                            //   ),
                            // );
                          },
                          child: const Text(
                            "View Files",
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
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
                          // print("Rating: $rating");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              color: ColorPallete.grey,
              child: StreamBuilder<List<LikecommentModel>>(
                stream: _likecommentStream.stream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: MaterialButton(
                        color: Colors.blue,
                        onPressed: () async {
                          fetchLikeComment(project.id);

                          setState(() {
                            _openEye = true;
                          });
                        },
                        child: const Text(
                          "Show Comments",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Error: ${snapshot.error}"),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Container(
                      color: ColorPallete.grey,
                      child: Scaffold(
                        backgroundColor: Colors.transparent,
                        floatingActionButton: _openEye
                            ? FloatingActionButton(
                                onPressed: () {
                                  showCustomDialog(
                                      context,
                                      RepositoryRatingsAdd(
                                        projID: project.id,
                                        reload: () {
                                          fetchLikeComment(project.id);
                                        },
                                      ));
                                },
                                child: const Icon(Icons.add))
                            : null,
                        body: const Center(
                          child: Text("NO COMMENTS YET"),
                        ),
                      ),
                    );
                  }

                  if (snapshot.hasData || snapshot.data!.isNotEmpty) {
                    final List<LikecommentModel> likecommentList =
                        snapshot.data!;

                    return Container(
                      color: ColorPallete.grey,
                      child: Scaffold(
                        backgroundColor: Colors.transparent,
                        floatingActionButton: _openEye
                            ? FloatingActionButton(
                                onPressed: () {
                                  showCustomDialog(
                                      context,
                                      RepositoryRatingsAdd(
                                        projID: project.id,
                                        reload: () {
                                          fetchLikeComment(project.id);
                                        },
                                      ));
                                },
                                child: const Icon(Icons.add))
                            : null,
                        body: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Column(
                              children: List.generate(
                                likecommentList.length,
                                (index) => _buildBody(
                                    index,
                                    context,
                                    likecommentList,
                                    fetchLikeComment,
                                    project.id),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget _buildBody(index, context, likecommentList, reload, projid) {
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
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          RatingBar.builder(
            ignoreGestures: true,
            initialRating: likecomment.rating.toDouble(),
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemSize: 15.0,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              // print("Rating: $rating");
            },
          ),
          const SizedBox(width: 10),
          UserSession.id == likecomment.userId
              ? IconButton(
                  onPressed: () {
                    showCustomDialog(
                        context,
                        RatingCommentUpdate(
                          projID: projid,
                          id: likecomment.id,
                          reload: () {
                            reload(projid);
                          },
                          rating: likecomment.rating,
                          comment: likecomment.comment,
                        ));
                  },
                  icon: const Icon(Icons.edit, color: Colors.grey))
              : const SizedBox(),
          UserSession.id == likecomment.userId
              ? IconButton(
                  onPressed: () {
                    confirmationDialog(
                        context,
                        "Delete your Comment and Rating ?",
                        "Click Yes to confirm", () {
                      deleteRatingComment(
                          context, likecomment.id, reload, projid);
                    });
                  },
                  icon: const Icon(Icons.delete, color: Colors.grey))
              : const SizedBox(),
        ],
      ),
    ),
  );
}
