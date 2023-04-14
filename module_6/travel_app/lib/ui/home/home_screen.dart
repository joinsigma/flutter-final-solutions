import 'package:flutter/material.dart';
import 'package:travel_app/ui/detail/detail_screen.dart';
import 'package:travel_app/ui/home/widgets/travel_package_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.orange,
                  ),
                ),
                prefixIcon: Icon(Icons.search),
                label: Text('Search'),
              ),
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              TravelPackageCard(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(),
                    ),
                  );
                },
              ),
              // TravelPackageCard(),
              // TravelPackageCard(),
              // TravelPackageCard(),
            ],
          ))
        ],
      ),
    );
  }
}
