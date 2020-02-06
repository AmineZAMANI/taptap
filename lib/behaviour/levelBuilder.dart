import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:taptap/bloc/lifeBloc.dart';
import 'package:taptap/components/creature.dart';

class LevelBuilder {
  int level;

  LevelBuilder(int _level) {
    this.level = _level;
  }

  static int randRange(int min, int max) {
    var random = new Random();
    return min + random.nextInt(max - min);
  }

  List<Widget> generate(LifeBloc _lifeBloc) {
    var screenItems = new List<Widget>();
    for (int i = 0; i <= getCountByLevel() - 1; i++) {
      screenItems.add(Align(
        child: new Creature(
            'assets/images/creature/creature.png', randRange(1, 12), _lifeBloc),
      ));
    }
    return screenItems;
  }

  static const chars = "abcdefghijklmnopqrstuvwxyz";

  static String generateRandomStrings(int length) {
    Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
    String result = "";
    for (var i = 0; i < length; i++) {
      result += chars[rnd.nextInt(chars.length)];
    }
    return result;
  }

  List<Widget> generateLetters(String word, LifeBloc _lifeBloc) {
    var screenItems = new List<Widget>();
    String withoutSpaces =
        word.replaceAll(' ', '').trim() + generateRandomStrings(4);
    print(withoutSpaces);
    for (int i = 0; i < withoutSpaces.length; i++) {
      var char = withoutSpaces[i];
      screenItems.add(Align(
        child: new Creature(char, i, _lifeBloc),
      ));
    }
    return screenItems;
  }

  int getCountByLevel() {
    switch (this.level) {
      case 1:
        return 8;
        break;
      case 2:
        return 10;
        break;
      case 3:
        return 8;
        break;
      case 4:
        return 8;
        break;
      case 5:
        return 6;
        break;
      case 6:
        return 6;
        break;
      case 7:
        return 5;
        break;
      case 8:
        return 5;
        break;
      case 9:
        return 5;
        break;
      case 10:
        return 4;
        break;
      default:
        return 4;
        break;
    }
  }
}
