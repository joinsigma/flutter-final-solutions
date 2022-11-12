import 'package:flutter/material.dart';
import 'package:my_whatsapp/commons/data.dart';

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
        children: [
          // Avatar Tile
          ListTile(
            leading: CircleAvatar(
              radius: 26.0,
              backgroundImage: NetworkImage(edit_profile_data['profile_pic']),
            ),
            subtitle: const Text(
                'Enter your name and add an optional profile picture'),
            tileColor: Colors.white,
            contentPadding: const EdgeInsets.fromLTRB(18.0, 26.0, 18.0, 5.0),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 33.0, vertical: 10.0),
            child: Text(
              'Edit',
              style: TextStyle(fontSize: 12.0, color: Colors.blue),
            ),
          ),

          const Divider(),

          // Name Input
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: edit_profile_data['profile_name'],
                hintStyle: const TextStyle(color: Colors.black),
                isDense: true,
                border: InputBorder.none,
              ),
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
