import 'package:flutter/material.dart';

class MyStatusListTile extends StatelessWidget {
  const MyStatusListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      leading: const CircleAvatar(
        radius: 19.0,
        backgroundImage: NetworkImage(
          'https://picsum.photos/id/1025/100/100',
        ),
      ),
      title: const Text('My Status'),
      subtitle: const Text('Add to my status'),
      visualDensity: const VisualDensity(vertical: -2),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              child: Container(
                width: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200],
                ),
                child: const Center(
                  child: Icon(
                    Icons.camera_alt,
                    size: 18.0,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              child: Container(
                width: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200],
                ),
                child: const Center(
                  child: Icon(
                    Icons.edit,
                    size: 18.0,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
