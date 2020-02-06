import 'package:rxdart/rxdart.dart';

import 'model/lifeUnit.dart';

class LifeBloc {
  LifeUnit lifeUnit = new LifeUnit(
      0); //if the data is not passed by paramether it initializes with 0
  BehaviorSubject<LifeUnit> _subject;
  int lastTouch = 1;

  LifeBloc({this.lifeUnit}) {
    _subject = new BehaviorSubject<LifeUnit>.seeded(
        this.lifeUnit); //initializes the subject with element already
  }

  ValueStream<LifeUnit> get observable => _subject.stream;

  void increment(double by) {
    lastTouch = 1;
    if (lifeUnit.value < 100) {
      lifeUnit.value += by;
    } else {
      lifeUnit.value = 100;
    }
    print("new life unit value after increment =>");
    print(lifeUnit.value);
    _subject.sink.add(lifeUnit);
  }

  void decrement(double by) {
    lastTouch = 0;
    if (lifeUnit.value > 0) {
      lifeUnit.value -= by;
    }

    if (lifeUnit.value < 0) {
      lifeUnit.value = 0;
    }
    print("new life unit value after decrement =>");
    print(lifeUnit.value);
    _subject.sink.add(lifeUnit);
  }

  void dispose() {
    _subject.close();
  }
}
