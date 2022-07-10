import 'package:flutter/material.dart';

class SuperheroScreen extends StatelessWidget {
  const SuperheroScreen({
    Key? key,
    required this.superheroData,
  }) : super(key: key);

  final Map<String, dynamic> superheroData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(superheroData['name']),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Container(
        color: Colors.yellow[200],
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Image.network(
              superheroData['imageUrl'],
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
