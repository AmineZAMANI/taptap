import 'package:flutter/cupertino.dart';
import 'package:taptap/bloc/lifeBloc.dart';
import 'package:taptap/states/lifeState.dart';

class Life extends StatefulWidget {
  final LifeBloc value;

  Life(this.value);

  @override
  State<StatefulWidget> createState() {
    return new LifeState(this.value);
  }
}
