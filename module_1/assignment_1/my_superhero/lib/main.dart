import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'My Superhero',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spiderman'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Container(
        color: Colors.yellow[200],
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Image.network(
              'https://www.pixel4k.com/wp-content/uploads/2019/09/little-spiderman-with-shield_1568054235-2048x1152.jpg',
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Text('Next'),
        backgroundColor: Colors.redAccent,
        onPressed: () {
          // Business logic to be implemented to trigger a new screen transition
        },
      ),
    );
  }
}
