import 'package:flutter_test/flutter_test.dart';
import 'counter.dart';

void main() {
  late Counter counter;

  ///setup method is called before each test
  setUp(() {
    counter = Counter();
  });

  ///teardown method is called after each method
  // tearDown(() => print('teardown called'));

  group("Initial values are correct", () {
    test('Initial value of count should be 0', () {
      expect(counter.count, 0);
    });
  });

  group("increment() function works correctly", () {
    test('Count value should be equal to 1 after first increment', () {
      ///Act
      counter.increment();

      ///Assert
      expect(counter.count, 1);
    });
  });

  group("incrementBySteps() function works correctly", () {
    test(
        'Count value should be equal to 1, after increment steps set at 2 and followed by decrement',
        () {
      ///Act
      counter.incrementBySteps(2);
      counter.decrement();

      ///Assert
      expect(counter.count, 1);
    });
  });

  group("decrement() function works correctly", () {
    test(
        ('Count value should be equal to 0 after first increment and decrement'),
        () {
      counter.increment();
      counter.decrement();
      expect(counter.count, 0);
    });
  });

  group("decrementBySteps() function works correctly", () {
    test(
        ('Count value should be equal to 0 if decrement steps is higher than count.'),
        () {
      ///Arrange
      counter.increment();

      ///Act
      counter.decrementBySteps(2);

      ///Assert
      expect(counter.count, 0);
    });
  });

}
