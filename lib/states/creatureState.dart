import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:taptap/bloc/lifeBloc.dart';
import 'package:taptap/components/creature.dart';
import 'package:taptap/components/life.dart';

class CreatureState extends State<Creature> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _upDownAnimation;

  double boomFactor;

  int randSize = randRange(30, 90);
  int smartness;
  String textValue;
  int iteration = 0;
  int canDraw = 0;
  double width;
  double height;
  double swipeX;
  double swipeY;
  Curve curve = Curves.linear;
  double dX = 0.0;

  bool swiped = false;

  Tween<Offset> tween;

  Widget _creatureImg;

  Life life;

  LifeBloc lifeBloc;

  bool _visible = true;

  var randomX;

  CreatureState(String _imagePath, int _smartness, LifeBloc _lifeBloc) {
    smartness = _smartness;
    this.lifeBloc = _lifeBloc;
    this.textValue = _imagePath;
  }

  Duration getCreatureSpeed() {
    dX = iteration % 2 == 0 ? 0.1 : -0.1;
    curve = randomCurve();
    return randomDuration();
  }

  static int randRange(int min, int max) {
    var random = new Random();
    return min + random.nextInt(max - min);
  }

  static double randRangeDouble(double rangeMin, double rangeMax) {
    Random r = new Random();
    return rangeMin + (rangeMax - rangeMin) * r.nextDouble();
  }

  final List<Color> circleColors = [
    Colors.greenAccent,
    Colors.pink,
    Colors.yellowAccent,
    Colors.deepPurple,
    Colors.lightGreenAccent
  ];

  Color randomColorGenerator() {
    return circleColors[new Random().nextInt(circleColors.length)];
  }

  final List<Curve> randomCurvesList = [
    Curves.fastLinearToSlowEaseIn,
    Curves.fastOutSlowIn
  ];

  Curve randomCurve() {
    return randomCurvesList[new Random().nextInt(randomCurvesList.length)];
  }

  final List<Duration> randomDurationsList = [
    Duration(milliseconds: 4000),
    Duration(milliseconds: 3600),
    Duration(milliseconds: 3400),
    Duration(milliseconds: 3200),
    Duration(milliseconds: 3000),
    Duration(milliseconds: 2800),
    Duration(milliseconds: 2600),
    Duration(milliseconds: 2400),
    Duration(milliseconds: 2000),
    Duration(milliseconds: 1900),
    Duration(milliseconds: 1600),
    Duration(milliseconds: 1000),
  ];

  Duration randomDuration() {
    return randomDurationsList[
        new Random().nextInt(randomDurationsList.length)];
  }

  @override
  void initState() {
    super.initState();
    initAnimationController();
    initOffsetAnimation();

    var creatureWidth = MediaQueryData.fromWindow(window).size.width / randSize;
    var creatureHeight =
        MediaQueryData.fromWindow(window).size.width / randSize;
    this.width = creatureWidth;
    this.height = creatureHeight;

    this.randomX = randRange(
            (this.width.toInt() * 3),
            MediaQueryData.fromWindow(window).size.width.toInt() -
                (this.width.toInt() * 3))
        .toDouble();

    _creatureImg = AnimatedOpacity(
        opacity: _visible ? 1.0 : 0.0,
        duration: Duration(milliseconds: 2000),
        child: Text(
          this.textValue,
          style: TextStyle(
              color: Colors.black,
              fontFamily: "supermario",
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  blurRadius: 5.0,
                  color: randomColorGenerator(),
                  offset: Offset(5.0, 5.0),
                )
              ],
              decorationStyle: TextDecorationStyle.solid,
              fontSize: randSize.toDouble()),
        ));
    boomFactor = randRange(1, 5).toDouble();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void initAnimationController() {
    _controller = AnimationController(
      duration: getCreatureSpeed(),
      vsync: this,
    )
      ..repeat(reverse: true)
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.forward) {
          _controller.duration = getCreatureSpeed();
        }
      });
  }

  void initOffsetAnimation() {
    tween = Tween<Offset>(
      begin: Offset(0.0, 1.5),
      end: Offset(dX, randRangeDouble(0.0, 0.9)),
    );
    CurvedAnimation curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: curve,
    );
    _upDownAnimation = tween.animate(curvedAnimation)
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.forward) {
          onAnimationEnd(curvedAnimation);
        }
      });
  }

  void onAnimationEnd(CurvedAnimation curvedAnimation) {
    if (!swiped) {
      tween.end = Offset(dX, randRangeDouble(0.0, 0.9));
      curvedAnimation.curve = curve;
      this.swiped = false;
      this.randomX = randRange(
              (this.width.toInt() * 3),
              MediaQuery.of(context).size.width.toInt() -
                  (this.width.toInt() * 3))
          .toDouble();
      setState(() {
        this.lifeBloc.decrement(boomFactor);
      });
    } else {
      setState(() {});
    }
  }

  Widget buildView() {
    return SlideTransition(
      position: _upDownAnimation,
      child: Stack(
        children: <Widget>[
          Positioned(
              child: GestureDetector(
                child: _creatureImg,
                onPanDown: (details) {
                  onPanDown(details);
                },
              ),
              right: randomX)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    iteration += 1;
    return buildView();
  }

  void onPanDown(DragDownDetails details) {
    canDraw = 1;
    lifeBloc.increment(boomFactor);
    if (!swiped) {
      this.swiped = true;
      swipeX = details.globalPosition.dx;
      swipeY = details.globalPosition.dy;
      _controller.duration = Duration(milliseconds: 800);
      _controller.reverse();
      _visible = false;
    }
  }
}
