import 'package:flutter/material.dart';
import 'package:repository_ustp/src/data/index/project_index_value.dart';
import 'package:repository_ustp/src/utils/palette.dart';

class CustomCard extends StatefulWidget {
  const CustomCard({super.key, required this.child, required this.callback});
  final int child;
  final Function callback;

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.callback(widget.child);
      },
      child: Container(
        height: 50,
        width: 200,
        decoration: BoxDecoration(
          color: ColorPallete.primary,
          borderRadius:
              BorderRadius.circular(8), // Optional: for rounded corners
        ),
        child: Center(
          child: Text(
            projectTypeBinaryValue(widget.child),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
