import 'package:flutter/material.dart';
import 'package:my_superhero/superhero_data.dart';
import 'package:my_superhero/superhero_screen.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
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
        title: const Text('Superhero'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Container(
        color: Colors.yellow[200],
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SuperheroScreen(
                    superheroData: superheroList[counter],
                  ),
                ),
              ),
              child: Image.network(
                superheroList[counter]['imageUrl'],
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Text('Next'),
        backgroundColor: Colors.redAccent,
        onPressed: () {
          setState(() {
            if (counter < superheroList.length - 1) {
              counter++;
            } else {
              counter = 0;
            }
          });
        },
      ),
    );
  }
}
