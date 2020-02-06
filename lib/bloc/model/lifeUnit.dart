import 'package:observable/observable.dart';

class LifeUnit extends ChangeRecord {
  double value;

  LifeUnit(double _value) {
    this.value = _value;
  }
}
