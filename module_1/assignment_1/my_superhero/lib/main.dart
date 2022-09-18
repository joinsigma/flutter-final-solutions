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
        backgroundColor: Colors.orange,
      ),
      body: Container(
        color: Colors.orangeAccent,
        child: Center(
          child: Image.network(
            'https://i.ebayimg.com/images/g/-qAAAOSw~AVYuw4n/s-l500.jpg',
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Text('Next'),
        backgroundColor: Colors.red,
        onPressed: () {
          // Business logic to be implemented to trigger a new screen transition
        },
      ),
    );
  }
}
