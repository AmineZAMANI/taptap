import 'package:flutter/widgets.dart';
import 'package:taptap/states/scoreState.dart';

class SpaceScore extends StatefulWidget {
  final int score;

  SpaceScore(this.score);

  @override
  State<StatefulWidget> createState() {
    return ScoreState(score);
  }
}
