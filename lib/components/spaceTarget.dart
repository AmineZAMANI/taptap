import 'package:flutter/widgets.dart';
import 'package:taptap/states/targetState.dart';

class SpaceTarget extends StatefulWidget {
  final int target;

  SpaceTarget(this.target);

  @override
  State<StatefulWidget> createState() {
    return TargetState(target);
  }
}
