import 'package:flutter/material.dart';
import 'package:my_weather/ui/city/city_screen.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'My Weather',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const CityScreen(),
    ),
  );
}
