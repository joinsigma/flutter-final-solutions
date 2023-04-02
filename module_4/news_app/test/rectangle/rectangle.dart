class Rectangle {
  ///Attributes
  int _width = 0;
  int _length = 0;
  int _height = 0;

  ///Constructor
  Rectangle();

  int calculateArea() {
    return _length * _width;
  }

  int calculateVolume() {
    return _length * _width * _height;
  }

  ///Setter
  set width(int width) => _width = width;
  set length(int length) => _length = length;
  set height(int height) => _height = height;

  ///Getter
  int get width => _width;
  int get length => _length;
  int get height => _height;
}
