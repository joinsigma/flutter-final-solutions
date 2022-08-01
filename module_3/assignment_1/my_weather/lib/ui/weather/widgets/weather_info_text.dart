import 'package:flutter/material.dart';

class WeatherInfoText extends StatelessWidget {
  const WeatherInfoText({
    Key? key,
    required this.label,
    required this.textValue,
  }) : super(key: key);

  final String label;
  final String textValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(textValue),
      ],
    );
  }
}
