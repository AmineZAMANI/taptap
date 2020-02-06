import 'package:flutter/widgets.dart';
import 'package:taptap/states/wordState.dart';

class SpaceWord extends StatefulWidget {
  final String word;

  SpaceWord(this.word);

  @override
  State<StatefulWidget> createState() {
    return WordState(word);
  }
}
