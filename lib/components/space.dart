import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui' as Ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:taptap/behaviour/levelBuilder.dart';
import 'package:taptap/bloc/lifeBloc.dart';
import 'package:taptap/bloc/model/lifeUnit.dart';
import 'package:taptap/components/spaceScore.dart';
import 'package:taptap/components/spaceTarget.dart';
import 'package:taptap/components/spaceTimer.dart';
import 'package:taptap/components/spaceWord.dart';

import 'life.dart';

class Space extends StatefulWidget {
  static const double MIN_LIFE_UNIT = 1.0;
  static const double MAX_LIFE_UNIT = 3.0;

  final String spaceImage;

  Space(this.spaceImage);

  @override
  State<StatefulWidget> createState() {
    return SpaceState(spaceImage);
  }
}

class SpaceState extends State<Space> implements CustomPainter {
  String spaceImage;

  static final String randomString = "Hello world";

  final SpaceScore wScore = SpaceScore(10);
  final SpaceTarget wTarget = SpaceTarget(100);
  final SpaceTimer wTimer = new SpaceTimer();
  final SpaceWord wMoves = new SpaceWord(randomString);

  final LifeBloc _lifeBloc = new LifeBloc(lifeUnit: new LifeUnit(100.0));

  Life wLife;

  bool drawLine = false;
  double dX;
  double dY;

  int bamCounter = 0;
  Ui.Image bamImage;

  double bamImageWidth;
  double bamImageHeight;

  SpaceState(spaceImage) {
    this.spaceImage = spaceImage;
  }

  @override
  Widget build(BuildContext context) {
    _enableLandscape();
    return MaterialApp(
      home: GestureDetector(
        onTapDown: (details) {
//          _lifeBloc.decrement(2.0);
          print("Drawing ...");
          this.dX = details.globalPosition.dx;
          this.dY = details.globalPosition.dy;
          bamCounter = 1;
          drawLine = true;
        },
        child: Container(
            child: buildGameStack(),
            padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
            decoration: BoxDecoration(
                image: new DecorationImage(
                    image: new ExactAssetImage(spaceImage),
                    fit: BoxFit.cover))),
      ),
    );
  }

  Stack buildGameStack() {
    return Stack(
      children: buildCreatures(10),
    );
  }

  int randRange(int min, int max) {
    var random = new Random();
    return min + random.nextInt(max - min);
  }

  List<Widget> buildCreatures(int count) {
    wLife = new Life(_lifeBloc);
    LevelBuilder levelBuilder = new LevelBuilder(1);
    List<Widget> screenItems = new List<Widget>();
    List<Widget> creatures =
        levelBuilder.generateLetters(randomString, _lifeBloc);
    screenItems.add(buildUserInformationArea());
    screenItems.add(CustomPaint(painter: this));
    screenItems.addAll(creatures);
    WidgetsBinding.instance.addPostFrameCallback((duration) => loadBamImage());
    return screenItems;
  }

  void loadBamImage() {
    int randSize = randRange(8, 12);
    bamImageWidth = MediaQueryData.fromWindow(window).size.width / randSize;
    bamImageHeight = MediaQueryData.fromWindow(window).size.width / randSize;
    rootBundle.load("assets/pam.png").then((image) {
      Uint8List lst = new Uint8List.view(image.buffer);
      Ui.instantiateImageCodec(lst,
              targetHeight: bamImageHeight.toInt(),
              targetWidth: bamImageWidth.toInt())
          .then((codec) {
        codec.getNextFrame().then((fi) {
          bamImage = fi.image;
          print("bam image loaded");
        });
      });
    });
  }

  Align buildTimerArea() {
    return Align(
      child: wTimer,
      alignment: Alignment.topCenter,
    );
  }

  Align buildUserInformationArea() {
    return Align(
      alignment: Alignment.topCenter,
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[wMoves, wLife],
          ),
          Column(
            children: <Widget>[],
          )
        ],
      ),
    );
  }

  void _enableLandscape() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void addListener(listener) {
    // TODO: implement addListener
  }

  @override
  bool hitTest(Offset position) {
    // TODO: implement hitTest
    return null;
  }

  @override
  void removeListener(listener) {
    // TODO: implement removeListener
  }

  @override
  // TODO: implement semanticsBuilder
  get semanticsBuilder => null;

  @override
  bool shouldRebuildSemantics(CustomPainter oldDelegate) {
    return null;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }

  @override
  void paint(Canvas canvas, Size size) async {
    final _paint = new Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;
    final _canvas = canvas;
    print(_lifeBloc.lastTouch);
    if (bamCounter < 40 && bamCounter > 0) {
      if (bamImage != null) {
        _canvas.drawImage(
            bamImage,
            Offset(dX - (bamImageWidth / 2), dY - (bamImageHeight / 2)),
            _paint);
        bamCounter++;
      }
    }
  }
}
