import 'package:flutter/material.dart';
import 'package:my_restaurant/data/data.dart';
import 'package:my_restaurant/injection_container.dart';
import 'package:my_restaurant/ui/search/search_restaurant_screen.dart';

void main() {
  initKiwi();
  runApp(
    MaterialApp(
      title: 'My Restaurant',
      theme: ThemeData(
        primarySwatch: Colors.red,
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
      backgroundColor: Colors.red[300],
      appBar: AppBar(
        title: const Text('Restaurant'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select an city',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12.0),
              Wrap(
                children: List.generate(
                  cityOptions.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 2.0,
                    ),
                    child: ActionChip(
                      label: Text(cityOptions[index]),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchRestaurantScreen(
                              location: cityOptions[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
