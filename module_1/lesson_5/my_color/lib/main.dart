import 'package:flutter/material.dart';
import 'dart:math' as math show Random;

void main() {
  runApp(
    MaterialApp(
      title: 'My Color',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Switching'),
      ),
      body: Container(
        color: containerColor[counter],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            counter = math.Random().nextInt(containerColor.length);
          });
        },
        tooltip: 'Switch Color',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

// Given a list of container color
List<Color> containerColor = [
  Colors.red,
  Colors.orange,
  Colors.yellow,
  Colors.green,
  Colors.blue,
  Colors.indigo,
  Colors.purple,
];
