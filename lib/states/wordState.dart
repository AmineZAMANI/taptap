import 'package:flutter/material.dart';
import 'package:taptap/components/spaceWord.dart';

class WordState extends State<SpaceWord> {
  String word;
  String movesLabel = "[word]";

  WordState(String _moves) {
    word = _moves;
  }

  @override
  Widget build(BuildContext context) {
    this.update(this.word);
    return Card(
      elevation: 6.0,
      margin: EdgeInsets.all(10),
      shape: OutlineInputBorder(gapPadding: 1.0),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          this.movesLabel,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontFamily: "supermario"),
        ),
      ),
    );
  }

  void update(String score) {
    this.movesLabel = this.movesLabel.replaceFirst("[word]", score.toString());
  }
}
