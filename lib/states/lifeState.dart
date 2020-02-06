import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:taptap/bloc/lifeBloc.dart';
import 'package:taptap/bloc/model/lifeUnit.dart';
import 'package:taptap/components/life.dart';

class LifeState extends State<Life> {
  LifeBloc lifeBloc;

  var life;

  LifeState(LifeBloc _value) {
    this.lifeBloc = _value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          minWidth: 0, maxWidth: MediaQuery.of(context).size.width),
      padding: EdgeInsets.all(10),
      child: Center(
        widthFactor: MediaQuery.of(context).size.width,
        child: new StreamBuilder(
            stream: lifeBloc.observable,
            builder: (context, AsyncSnapshot<LifeUnit> snapshot) {
              return RoundedProgressBar(
                  style:
                      RoundedProgressBarStyle(borderWidth: 0, widthShadow: 0),
                  percent: snapshot.data != null ? snapshot.data.value : 100.0,
                  theme: RoundedProgressBarTheme.purple);
            }),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
