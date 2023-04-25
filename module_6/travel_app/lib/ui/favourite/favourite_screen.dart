import 'package:flutter/material.dart';
import 'package:travel_app/ui/favourite/widgets/favourite_card.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8.0, top: 20, bottom: 8.0),
            child: Text(
              'Your Likes',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
          ),
          // Divider(),
          Expanded(
            child: ListView(
              children: const [
                FavouriteCard(),
                FavouriteCard(),
                FavouriteCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
