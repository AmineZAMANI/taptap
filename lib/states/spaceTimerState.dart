import 'dart:async';

import 'package:flutter/material.dart';
import 'package:taptap/components/spaceTimer.dart';

class SpaceTimerState extends State<SpaceTimer> {
  Timer _timer;
  int _start = 10;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text("$_start"),
      onTap: () {
        setState(() {
          _start = 10;
          startTimer();
        });
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            showGameOver();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  void showGameOver() {}
}
