import 'package:flutter/material.dart';
import 'package:taptap/components/spaceScore.dart';
import 'package:taptap/components/spaceTarget.dart';

class TargetState extends State<SpaceTarget> {
  int target;
  String targetLabel = "Target : [target]";

  TargetState(int _target) {
    target = _target;
  }

  @override
  Widget build(BuildContext context) {
    this.update(this.target);
    return Text(
      this.targetLabel,
      style: TextStyle(fontSize: 20),
      textAlign: TextAlign.left,
    );
  }

  void update(int score) {
    this.targetLabel =
        this.targetLabel.replaceFirst("[target]", score.toString());
  }
}
