import 'package:flutter/material.dart';
import 'package:taptap/components/spaceScore.dart';

class ScoreState extends State<SpaceScore> {
  int score;
  String scoreLabel = "Score : [score]";

  ScoreState(int _score) {
    score = _score;
  }

  @override
  Widget build(BuildContext context) {
    this.update(this.score);
    return Text(
      this.scoreLabel,
      style: TextStyle(fontSize: 20),
      textAlign: TextAlign.left,
    );
  }

  void update(int score) {
    this.scoreLabel = this.scoreLabel.replaceFirst("[score]", score.toString());
  }
}
