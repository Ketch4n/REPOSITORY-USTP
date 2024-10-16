import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:repository_ustp/src/pages/repository/components/functions/update_ratingcomment.dart';
import 'package:repository_ustp/src/utils/palette.dart';

class RatingCommentUpdate extends StatefulWidget {
  const RatingCommentUpdate({
    super.key,
    required this.projID,
    required this.id,
    required this.reload,
    required this.rating,
    required this.comment,
  });
  final int projID;
  final int id;
  final Function reload;
  final int rating;
  final String comment;

  @override
  State<RatingCommentUpdate> createState() => _RatingCommentUpdateState();
}

class _RatingCommentUpdateState extends State<RatingCommentUpdate> {
  final TextEditingController comment = TextEditingController();
  int ratingValue = 0;

  @override
  void initState() {
    comment.text = widget.comment;
    ratingValue = widget.rating;
    super.initState();
  }

  @override
  void dispose() {
    comment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 600, minWidth: 500),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 50,
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: ColorPallete.skyblueLite,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
            child: const Center(
                child: Text(
              "UPDATE - Rating and Comment",
              style: TextStyle(fontSize: 20, color: Colors.white),
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: RatingBar.builder(
                      ignoreGestures: false,
                      initialRating: ratingValue.toDouble(),
                      minRating: 0,
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
                        ratingValue = rating.toInt();
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    color: HexColor('D9D9D9'),
                    child: TextFormField(
                      controller: comment,

                      keyboardType:
                          TextInputType.multiline, // Allow multiline input
                      maxLines: null,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Comment...',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    flex: 2,
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          comment.clear();
                        },
                        child: const Text("Cancel"))),
                Flexible(
                    flex: 2,
                    child: MaterialButton(
                      color: Colors.blue,
                      onPressed: () {
                        final projid = widget.projID;
                        final ratingIndex = ratingValue;
                        final commentValue = comment.text.trim();

                        updateRatingComment(
                          context,
                          projid,
                          widget.id,
                          widget.reload,
                          ratingIndex,
                          commentValue,
                        );
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
