import 'package:flutter/material.dart';
import 'package:my_crypto/ui/home/home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'My Crypto',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    ),
  );
}


