import 'package:flutter/material.dart';
import 'package:taptap/bloc/lifeBloc.dart';
import 'package:taptap/states/creatureState.dart';

class Creature extends StatefulWidget {
  final int smartness;
  final LifeBloc _lifeBloc;
  final String _imagePath;

  Creature(this._imagePath, this.smartness,this._lifeBloc);

  @override
  State<Creature> createState() {
    return CreatureState(_imagePath, smartness,_lifeBloc);
  }
}
