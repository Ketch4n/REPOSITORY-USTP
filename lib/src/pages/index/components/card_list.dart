import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/card.dart';

class CardList extends StatefulWidget {
  const CardList({super.key, required this.callback});
  final Function callback;

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.center,
      child: Wrap(
        runSpacing: 10.0,
        spacing: 10.0,
        direction: Axis.horizontal,
        alignment: WrapAlignment.center,
        children: [
          CustomCard(child: 0, callback: widget.callback),
          CustomCard(child: 1, callback: widget.callback),
          CustomCard(child: 2, callback: widget.callback),
          CustomCard(child: 3, callback: widget.callback),
        ],
      ),
    );
  }
}
