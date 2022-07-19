import 'package:flutter/material.dart';

class EditProfileTile extends StatelessWidget {
  const EditProfileTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          // Avatar Tile
          ListTile(
            leading: CircleAvatar(
              radius: 26.0,
              backgroundImage:
                  NetworkImage('https://picsum.photos/id/1025/100/100'),
            ),
            subtitle:
                Text('Enter your name and add an optional profile picture'),
            tileColor: Colors.white,
            contentPadding: EdgeInsets.fromLTRB(18.0, 26.0, 18.0, 5.0),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 33.0, vertical: 10.0),
            child: Text(
              'Edit',
              style: TextStyle(fontSize: 12.0, color: Colors.blue),
            ),
          ),

          Divider(),

          // Name Input
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Calibre Cliff',
                hintStyle: TextStyle(color: Colors.black),
                isDense: true,
                border: InputBorder.none,
              ),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
