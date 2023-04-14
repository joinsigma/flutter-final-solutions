import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String count;
  final String title;
  const ProfileCard({Key? key, required this.count, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            count,
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 16.0),
          )
        ],
      ),
    );
  }
}
