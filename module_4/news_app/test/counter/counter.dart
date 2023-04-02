class Counter {
  ///Attributes
  int _count = 0;

  ///Constructor
  Counter();

  ///Methods
  void increment() => _count++;

  void decrement() {
    ///Allow decrement only if _count is positive.
    if (_count > 0) {
      _count -= 1;
    }
  }

  void incrementBySteps(int step) {
    _count += step;
  }

  void decrementBySteps(int step) {
    _count -= step;

    ///Check if count is negative, if so reset to 0.
    if (_count < 0) {
      _count = 0;
    }
  }

  ///Getter
  int get count => _count;
}
