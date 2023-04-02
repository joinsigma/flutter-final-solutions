import 'package:flutter_test/flutter_test.dart';

import 'rectangle.dart';

void main() {
  late Rectangle rectangle;
  setUp(() {
    rectangle = Rectangle();
  });

  group("Initial values are correct", () {
    test("height,width and length is equal to 0", () {
      expect(rectangle.width, 0);
      expect(rectangle.height, 0);
      expect(rectangle.length, 0);
    });

    test("height,width and length are correct after set", () {
      ///Act
      rectangle.width = 10;
      rectangle.height = 5;
      rectangle.length = 2;

      ///Assert
      expect(rectangle.width, 10);
      expect(rectangle.height, 5);
      expect(rectangle.length, 2);
    });
  });

  group("calculateArea()", () {
    test("Area calculated correctly", () {
      ///Arrange
      rectangle.width = 10;
      rectangle.length = 2;
      rectangle.height = 5;

      ///Act
      final area = rectangle.calculateArea();

      ///Assert
      expect(area, 10 * 2);
    });

    test("Area calculated correctly if volume is 0", () {
      ///Arrange
      rectangle.width = 10;
      rectangle.length = 2;
      rectangle.height = 0;

      ///Act
      final area = rectangle.calculateArea();

      ///Assert
      expect(area, 10 * 2);
    });
  });

  group("calculateArea()", () {
    test("volume calculated correctly", () {
      ///Arrange
      rectangle.width = 10;
      rectangle.length = 2;
      rectangle.height = 5;

      ///Act
      final volume = rectangle.calculateVolume();

      ///Assert
      expect(volume, 10 * 2 * 5);
    });

    test("Volume calculated correctly if any parameter is 0", () {
      ///Arrange
      rectangle.width = 10;
      rectangle.length = 2;
      rectangle.height = 0;

      ///Act
      final volume = rectangle.calculateVolume();

      ///Assert
      expect(volume, 0);
    });
  });
}
